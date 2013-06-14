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

require 'yammer/http_adapter'

module Yammer
  module Configurable

    ENDPOINT = 'https://www.yammer.com' unless defined? ENDPOINT
    HTTP_ADAPTER = Yammer::HttpAdapter unless defined? HTTP_CONNECTION

    attr_accessor :client_id, :client_secret, :access_token, :site_url,
    :connection_options, :default_headers, :http_adapter

    # Return a hash with the default options
    # @return [Hash]
    def self.default_options
      {
        :site_url           => ENDPOINT,
        :client_id          => ENV['YAMMER_CLIENT_ID'],
        :client_secret      => ENV['YAMMER_CLIENT_SECRET'],
        :access_token       => ENV['YAMMER_ACCESS_TOKEN'],
        :http_adapter       => HTTP_ADAPTER,
        :connection_options => { :max_redirects => 5, :verify_ssl => true },
        :default_headers    => {
          'Accept'     => 'application/json',
          'User-Agent' => "Yammer Ruby Gem #{Yammer::Version}"
        }
      }
    end

    # @return [Array<String>]
    def self.keys
      self.default_options.keys
    end

    # @return [Hash]
    def options
      Hash[Yammer::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    def reset!
      Yammer::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Yammer::Configurable.default_options[key.to_sym])
      end
      self
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self if block_given?
      self
    end

    def enable_logging(output='stdout')
      self.http_adapter.log = output
    end

    def disable_logging
      self.http_adapter.log = nil
    end

    def with_logging(output)
      cached_output = self.http_adapter.log
      enable_logging(output)
      yield self if block_given?
      self.http_adapter.log = cached_output
    end
  end
end
