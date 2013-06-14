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
    module Search

      # @see https://developer.yammer.com/restapi/#rest-search
      # @api_path /api/v1/search
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the options to fetch a thread with
      # @option opts [Integer] :num_per_page
      # @option opts [Integer] :page
      # @option opts [Integer] :search_group
      # @option opts [Integer] :search_user
      # @option opts [String] :search_sort
      # @option opts [String] :match
      # @option opts [String] :model_types
      # @option opts [String] :search_startdate
      # @option opts [String] :search_enddate
      # @example Search for a particular term on within current user's network
      #   Yammer.search(:search => 'documents')
      def search(opts={})
        get('/api/v1/search', opts)
      end
    end
  end
end