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

module Yammer
  class ApiResponse

    attr_reader :code, :headers

    def initialize(headers, body, code)
      @headers = headers
      @body    = body
      @code    = code.to_i
    end

    def raw_body
      @body
    end

    def body
      @parsed_body ||= parse(@body)
    end

    def empty?
      @body.nil? || @body.strip.empty?
    end

    def success?
      @code == 200
    end

    def created?
      @code == 201
    end

  private

    def parse(body)
      case body
      when /\A^\s*$\z/, nil
        nil
      else
        MultiJson.load(body, :symbolize_keys => true)
      end
    end
  end
end