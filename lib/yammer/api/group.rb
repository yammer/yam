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
    module Group

      # @see https://developer.yammer.com/restapi/#rest-groups
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the opts to fetch a thread with
      # @option opts [Integer] :page
      # @option opts [String] :sort_by sort groups by created_on, creator, name default order is by number of messages
      # @option opts [String] :letter groups starting with letter
      # @example Fetch all groups for authenticated user's network
      #   Yammer.all_groups
      def all_groups(opts={})
        get("/api/v1/groups", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-groups
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the group ID
      # @example Fetch data for specified group
      #   Yammer.get_group(74)
      def get_group(id)
        get("/api/v1/groups/#{id}")
      end

      # @see https://developer.yammer.com/restapi/#rest-groups
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the opts to fetch a thread with
      # @option opts [String] :name
      # @option opts [String] :description
      # @option opts [Boolean] :private
      # @option opts [Boolean] :show_in_directory
      # @example Create a new public group
      #   Yammer.create_group(:name => "new group name", :private => "false")
      def create_group(opts={})
        post("/api/v1/groups", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-groups
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the group ID
      # @param [Hash] opts
      # @option opts [String] :name
      # @option opts [String] :description
      # @option opts [Boolean] :private
      # @option opts [Boolean] :show_in_directory
      # @example Update data for a given group
      #   Yammer.update_group(74, :name => "new group name")
      def update_group(id, opts={})
        post("/api/v1/groups/#{id}", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-groups
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the user ID
      # @example Fetch groups for a given user
      #   Yammer.groups_for_user(74)
      def groups_for_user(id)
        get("/api/v1/groups/for_user/#{id}")
      end
    end
  end 
end