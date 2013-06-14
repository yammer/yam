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
  class Message < Yammer::Base

    attr_accessor_deffered :direct_message, :privacy, :group_id, :created_at,
    :attachments, :liked_by, :chat_client_sequence, :client_url, :content_excerpt,
    :message_type, :url, :web_url, :network_id, :system_message, :client_type, 
    :sender_type, :sender_id, :thread_id, :conversation_id, :replied_to_id, :body

    attr_reader :replied_to_id

    # Creates a new message
    # @!scope class
    def self.create(body, params={})
      api_handler.create_message(body, params)
    end

  end
end