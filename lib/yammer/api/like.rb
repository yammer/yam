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
    module Like

      # Delivers a ‘like’ action to the activity stream
      # @see https://developer.yammer.com/
      # @api_path /api/v1/likes
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Integer] id
      # @param [String]  type
      def like(type, id)
        post('/api/v1/likes', :id => id, :type => type)
      end

      # Unlike
      # @see https://developer.yammer.com/
      # @api_path /api/v1/likes
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Integer] id
      def unlike(id)
        delete("/api/v1/likes/#{id}")
      end

      # Used to determine if current user likes ogo
      # @see https://developer.yammer.com/
      # @api_path /api/v1/likes
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Integer] id
      def likes_open_graph_object?(id)
        get("/api/v1/likes/open_graph_object/#{id}")
      end
    end
  end
end
