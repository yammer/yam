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
    module Invitation

      # @see https://developer.yammer.com/restapi/#rest-invitations
      # @api_path /api/v1/invitations
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [String, Array] email or list of email addresses to send invitations to
      # @example Fetch data for the thread
      #
      #   Yammer.invite(%{ bob@yammer.com alice@yammer.com })
      #
      #   Yammer.invite('bob@yammer.com, alice@yammer.com')
      def invite(email)
        email = email.strip if email.is_a?(String)
        email = email.join(',') if email.is_a?(Array)
        post('/api/v1/invitations', :email => email)
      end
    end
  end
end