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
    module Network

      # @see https://developer.yammer.com/restapi/#rest-network
      # @api_path /api/v1//networks/current
      # @rate_limited Yes
      # @authentication authenticated user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the options to fetch a thread with
      # @option opts [Boolean] :include_suspended
      # @option opts [Boolean] :exclude_own_messages_from_unseen
      # @example Fetch all networks that the current user is a member of
      #   Yammer.current_networks
      def current_networks(opts={})
        get('/api/v1/networks/current', opts)
      end
    end
  end
end