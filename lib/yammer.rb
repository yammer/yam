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

require 'yammer/version'
require 'yammer/error'
require 'yammer/configurable'
require 'yammer/api'
require 'yammer/http_adapter'
require 'yammer/client'
require 'yammer/api_handler'
require 'yammer/api_response'
require 'yammer/models'

module Yammer
  class << self
    include Configurable
    include ApiHandler

    def to_s
      "<#{self.name}: #{self.options.inspect}>"
    end

  private
    def method_missing(method_name, *args, &block)
      return super unless api_handler.respond_to?(method_name)
      api_handler.send(method_name, *args, &block)
    end
  end
end

Yam = Yammer

Yammer.reset!