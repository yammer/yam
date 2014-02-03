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
    module Message

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param body [String] Message body
      # @param [Hash] opts the options to create a message with
      # @option opts [Array<Integer>] :cc
      # @option opts [Integer] :replied_to_id
      # @option opts [Integer] :group_id 
      # @option opts [Array<Integer>] :direct_to_user_ids
      # @option opts [Array<Integer>] :pending_attachment_ids
      # @example Create a new message
      #   msg1 = Yammer.create_message('what are you workings on?')
      #
      #   msg2 = Yammer.create_message('building a yammer client', :replied_to_id => msg.id)
      def create_message(body, opts={})
        opts[:body] = body
        opts[:cc] = "[[user:#{opts[:cc].join("]],[[user:")}]]" if !opts[:cc].nil? && opts[:cc].is_a?(Array)
        post("/api/v1/messages", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise [Yammer::Error::BadRequest] Error raised when you try to delete a message that
      #   you did not create      
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the thread ID
      # @example Delete an existing message
      #   result = Yammer.delete_message(1)
      def delete_message(id)
        delete("/api/v1/messages/#{id}")
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the ID of the message to be fetched
      # @example Fetch an existing message
      #   msg = Yammer.get_message(3)
      def get_message(id)
        get("/api/v1/messages/#{id}")
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch a list of messages from the company feed
      #   msgs = Yammer.all_messages
      def all_messages(opts={})
        get("/api/v1/messages", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch list messages sent by authenticated user
      #   msgs = Yammer.messages_sent
      def messages_sent(opts={})
        get("/api/v1/messages/sent", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch list of messages sent to authenitcated user
      #   msgs = Yammer.messages_received
      def messages_received(opts={})
        get("/api/v1/messages/received", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch a list of private messages sent to authenitcated user
      #   msgs = Yammer.private_messages
      def private_messages(opts={})
        get("/api/v1/messages/private", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch a list of messages being followed by authenitcated user
      #   msgs = Yammer.followed_messages
      def followed_messages(opts={})
        get("/api/v1/messages/following", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the ID of the user whose public messages we want to look at
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch a list of messages sent by a user in the authenticated user's network
      #   msgs = Yammer.messages_from_user(8)
      def messages_from_user(id, opts={})
        get("/api/v1/messages/from_user/#{id}", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the topic ID
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch messages that have been tagged with a given topic
      #   msgs = Yammer.messages_about_topic(1)
      def messages_about_topic(id, opts={})
        get("/api/v1/messages/about_topic/#{id}", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the ID of the group whose messages you wish to fetch
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch a list of messages in a given group
      #   msgs = Yammer.messages_in_group(38)
      def messages_in_group(id, opts={})
        get("/api/v1/messages/in_group/#{id}", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the ID of the user for whom you wish to get a list of messages they have liked
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch a list of messages liked by a given user
      #   msgs = Yammer.messages_liked_by(4)
      def messages_liked_by(id, opts={})
        get("/api/v1/messages/liked_by/#{id}", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages/liked_by/current.json?message_id=[:id]
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the ID of the message for which you want the current user to mark as liked
      # @example Marks the specified message as liked by the current user
      #   msgs = Yammer.like_message(10)
      def like_message(id)
        post("/api/v1/messages/liked_by/current.json?message_id=#{id}", {})
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages/liked_by/current.json?message_id=[:id]
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the ID of the message for which you want the current user to remove the like mark
      # @example Removes the like mark on the specified message for the current user
      #   msgs = Yammer.like_message(10)
      def unlike_message(id)
        delete("/api/v1/messages/liked_by/current.json?message_id=#{id}", {})
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the thread ID
      # @param [Hash] opts the options to fetch the messages with
      # @option opts [Integer] :newer_than
      # @example Fetch a list of messages in a given thread
      #   msgs = Yammer.messages_in_thread(10)
      def messages_in_thread(id, opts={})
        get("/api/v1/messages/in_thread/#{id}", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-messages
      # @api_path /api/v1/messages/open_graph_objects
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer] the thread ID
      # @example Fetch a list of messages in a given thread
      #   msgs = Yammer.messages_for_open_graph_pbject(10)
      def messages_for_open_graph_object(id)
        get("/api/v1/messages/open_graph_objects/#{id}")
      end
    end
  end 
end
