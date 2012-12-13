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

# API setup and configuration
require 'yam/request'
require 'yam/connection'
require 'yam/configuration'

module Yam
  class API
    include Connection
    include Request
    attr_reader *Configuration::VALID_OPTIONS_KEYS

    class_eval do
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        define_method "#{key}=" do |arg|
          self.instance_variable_set("@#{key}", arg)
          Yam.send("#{key}=", arg)
        end
      end
    end

    def initialize(oauth_token, endpoint)
      @oauth_token = oauth_token
      @endpoint = endpoint
      setup({})
    end

    def setup(options={})
      options = Yam.options.merge(options)

      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def method_missing(method, *args, &block)
      if method.to_s.match /^(.*)\?$/
        return !self.send($1.to_s).nil?
      end
    end
  end
end
