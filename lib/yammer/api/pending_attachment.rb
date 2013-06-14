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
    module PendingAttachment

      # Create a new pending attachment owned by authenticated user
      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/pending_attachments
      # @rate_limited Yes
      # @authentication User context
      # @raise [Yammer::Error::Unauthorized Yammer::Error::Forbidden] Error when supplied user credentials are not valid
      #   when user network does not allow attachments
      # @return [Yammer::ApiResponse]
      # @example Fetch existing pending attachment
      #   Yammer.get_pending_attachment(62)
      def get_pending_attachment(id)
        get("/api/v1/pending_attachments/#{id}")
      end

      # Delete a pending attachment owned by the authenticated user
      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/pending_attachments
      # @rate_limited Yes
      # @authentication User context
      # @raise [Yammer::Error::Unauthorized Yammer::Error::NotFound] Error raised when supplied user credentials are not valid
      #   when attachment cannot be found
      # @return [Yammer::ApiResponse]
      # @example Delete existing pending attachment
      #   Yammer.delete_pending_attachment(34)
      def delete_pending_attachment(id)
        delete("/api/v1/pending_attachments/#{id}")
      end

      # Fetch a pending attachment owned by authenticated user
      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/pending_attachments
      # @rate_limited Yes
      # @authentication User context
      # @raise [Yammer::Error::Unauthorized Yammer::Error::NotFound] Error raised when supplied user credentials are not valid
      #   when attachment cannot be found
      # @return [Yammer::ApiResponse]
      # @example Create new pending attachment
      #   file = File.open('~/attachment.txt', 'r')
      #   Yammer.create_pending_attachment(file)
      #
      def create_pending_attachment(attachment)
        post("/api/v1/pending_attachments", :attachment => attachment)
      end
    end
  end
end
