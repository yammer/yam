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

module Yam
  module Configuration
    DEFAULT_ADAPTER = :net_http
    DEFAULT_API_ENDPOINT = 'https://www.yammer.com/api/v1/'
    DEFAULT_USER_AGENT = "Yam Ruby Gem #{Yam::VERSION}".freeze
    VALID_OPTIONS_KEYS = [:adapter, :endpoint, :user_agent].freeze

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.set_defaults
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each { |k| options[k] = send(k) }
      options
    end

    def set_defaults
      self.adapter = DEFAULT_ADAPTER
      self.endpoint = DEFAULT_API_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
      self
    end
  end
end
