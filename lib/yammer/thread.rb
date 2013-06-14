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
  class Thread < Yammer::Base

    attr_accessor_deffered :participants, :web_url, :references, :thread_starter_id,
    :type, :privacy, :has_attachments, :attachments_meta, :topics, :url, :attachments,
    :direct_message, :participants_count, :stats

    def first_reply_id
      stats[:first_reply_id]
    end

    def first_reply
      @first_reply ||= first_reply_id ? Yammer::Message.new(:id => first_reply_id) : nil
    end

    def latest_reply_id
      stats[:latest_reply_id]
    end

    def last_reply
      @latest_reply ||= latest_reply_id ? Yammer::Message.new(:id => latest_reply_id) : nil
    end

    def people
      @people ||= begin
        @participants.map do |part|
          next unless part[:type] == 'user'
          Yammer::User.new(:id => part[:id])
        end
      end
      @people
    end

    def messages
      @messages = {}
      result = api_handler.messages_in_thread(self.id)
      msgs = result.body[:messages].each do |message|
        msg = Yammer::Message.new(message)
        @messages["#{msg.id}"] = msg
      end
      @messages
    end
  end
end