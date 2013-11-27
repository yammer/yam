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
  module Resources
    class IdentityMap

      class InvalidKeyError < StandardError; end

      def initialize
        @map  = {}
        @size = 0
      end

      # @note retrives key from identity map
      # @return [Hash]
      # @param key [string] 
      # @param default [Hash]
      def get(key, default=nil)
        @map["#{key}"] || default
      end

      # @note inserts a hash of attributes into identity map
      # @return [Hash]
      # @param key [string] 
      # @param value [Hash]
      def put(key, value)
        if key.nil? || key.empty?
          raise InvalidKeyError.new
        end
        @map["#{key}"] = value
      end

      # @note returns the current size of identity map
      # @return [Integer]
      def size
        @map.keys.count
      end

      # clears the entire identity map
      # @return [Hash]
      def purge!
        @map = {}
      end
    end
  end
end