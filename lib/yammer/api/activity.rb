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
    module Activity

      # @see https://developer.yammer.com/opengraph
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the opts to post the activity with
      # @option opts [Hash] actor The user performing the action
      # @option actor [String] :email
      # @option actor [String] :name
      # @option opts [Hash] object The object on which the action is being performed
      # @option object [String] :url
      # @option object [String] :title
      # @option opts [String] :action
      # @option opts [Array<Hash>] :users
      # @option users [String] :name
      # @option users [String] :email
      # @option opts [Boolean] :private
      # @option opts [String] :message
      # @example Create a new public group
      #   Yammer.create_activity(
      #     activity: {
      #        actor: {
      #        name: 'John Doe',
      #        email: 'jdoe@yammer-inc.com'
      #        },
      #      action: 'create',
      #        object: {
      #          url: 'www.example.com',
      #          title: 'Example name',
      #        }
      #      },
      #      message: 'Posting activity',
      #      users: [{
      #        name: 'Example Invitee',
      #        email: 'example@yammer-inc.com'
      #      }]
      #    }
      def create_activity(opts = {})
        post('/api/v1/activity', opts)
      end
    end
  end
end
