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
    module GroupMembership

      # @see https://developer.yammer.com/restapi/#rest-group_memberships
      # @api_path /api/v1/group_memberships/id
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the group membership ID
      # @example Fetch data for the thread
      #   Yammer.get_group_membership(7)
      def get_group_membership(id)
        get("/api/v1/group_memberships/#{id}")
      end

      # @see https://developer.yammer.com/restapi/#rest-groups
      # @api_path /api/v1/group_memberships
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the group ID
      # @example Fetch data for the thread
      #   Yammer.create_group_membership(74)
      def create_group_membership(id)
        post("/api/v1/group_memberships", :group_id => id)
      end
    end
  end 
end