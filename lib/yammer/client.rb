# Copyright (c) Microsoft Corporation
# All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 
#
# THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR 
# CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING 
# WITHOUT LIMITATION ANY IMPLIED WARRANTIES OR CONDITIONS OF TITLE,
# FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABLITY OR NON-INFRINGEMENT. 

# See the Apache Version 2.0 License for specific language governing
# permissions and limitations under the License.

require 'yammer/api'
require 'yammer/configurable'
require 'yammer/http_adapter'

module Yammer
  class Client

    include Yammer::Configurable
    include Yammer::Api::User
    include Yammer::Api::Group
    include Yammer::Api::GroupMembership
    include Yammer::Api::Message
    include Yammer::Api::Thread
    include Yammer::Api::Topic
    include Yammer::Api::Network
    include Yammer::Api::Search
    include Yammer::Api::Like
    include Yammer::Api::Notification
    include Yammer::Api::Autocomplete
    include Yammer::Api::Invitation
    include Yammer::Api::PendingAttachment
    include Yammer::Api::Subscription
    include Yammer::Api::OpenGraphObject

    attr_reader :site_url, :default_headers, :connection_options

    attr_accessor :client_id, :client_secret, :access_token

    def initialize(opts={})
      Yammer::Configurable.keys.each do |key|
        case key
        when :headers, :connection_options
          value = Yammer.instance_variable_get(:"@#{key}").merge(opts.fetch(key, {}))
        else
          value = opts.fetch(key, Yammer.instance_variable_get(:"@#{key}"))
        end
        instance_variable_set(:"@#{key}", value)
      end
    end

    # makes a GET request
    def get(path, params={})
      request(:get, path, params)
    end

    # makes a PUT request
    def put(path, params={})
      request(:put, path, params)
    end

    # makes a POST request
    def post(path, params={})
      request(:post, path, params)
    end

    # makes a DELETE request
    def delete(path, params={})
      request(:delete, path, params)
    end

  private

    # returns an instance of the http adapter
    # if none is specified, the default is Yammer::HttpConnection
    # @!visibility private
    def http_client
      @http_client ||= @http_adapter.new(@site_url, @connection_options)
    end

    # Makes an HTTP request using the provided parameters
    # @raise [Yammer::Error::Unauthorized]
    # @param method [string]
    # @param path [string]
    # @param params [Hash]
    # @return [Yammer::ApiResponse]
    # @!visibility private
    def request(method, path, params={})
      headers = @default_headers.merge({'Authorization' => "Bearer #{@access_token}"})
      result = http_client.send_request(method, path, {
        :params  => params,
        :headers => headers
      })
      result
    end
  end
end
