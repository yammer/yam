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
  module Api
    module Topic

      # @see https://developer.yammer.com/restapi/#rest-topics
      # @api_path /api/v1/topics
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied
      #   user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer]
      # @param [Hash] opts the options to fetch a thread with
      # @option opts [Integer] :is_followed_by include if specified user
      #   is following topic that is being fetched
      # @example Fetch data for the thread
      #   Yammer.get_topic(42, :is_followed_by => 2)
      def get_topic(id, opts={})
        get("/api/v1/topics/#{id}", opts)
      end
    end
  end 
end