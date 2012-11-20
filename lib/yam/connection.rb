# Copyright (c) Microsoft Corporation
# All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY
# IMPLIED WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR
# PURPOSE, MERCHANTABLITY OR NON-INFRINGEMENT.
#
# See the Apache Version 2.0 License for specific language governing
# permissions and limitations under the License.
#
require 'faraday'
require 'yam/constants'
require 'faraday_middleware/response/mashify'
require 'faraday_middleware/response/parse_json'
require 'faraday_middleware/request/oauth2'

module Yam
  module Connection
    extend self
    include Yam::Constants

    def default_options(options={})
      {
        :headers => {
          ACCEPT           => 'application/json',
          ACCEPT_CHARSET   => 'utf-8',
          USER_AGENT       => user_agent
        },
        :ssl => { :verify => false },
        :url => options.fetch(:endpoint) { Yam.endpoint }
      }.merge(options)
    end

    # Returns a Faraday::Connection object
    #
    def connection(options = {})
      conn_options = default_options(options)
      clear_cache unless options.empty?
      puts "OPTIONS:#{conn_options.inspect}" if ENV['DEBUG']

      @connection ||= Faraday.new(conn_options) do |conn|
        conn.use Faraday::Response::Mashify
        conn.use FaradayMiddleware::ParseJson
        conn.response :raise_error

        if oauth_token?
          conn.use FaradayMiddleware::OAuth2, oauth_token
        end

        conn.request :url_encoded
        conn.adapter adapter
      end
    end
  end
end
