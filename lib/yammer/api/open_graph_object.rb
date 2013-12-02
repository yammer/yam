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
    module OpenGraphObject

      # @see https://developer.yammer.com/
      # @api_path /api/v1/open_graph_objects/
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [String] url The URL of the open graph object
      # @param [Hash] props The properties of this open graph object
      # @option props [String] :image
      # @option props [String] :description
      # @option props [String] :site_name
      # @option props [String] :title
      # @option props [String] :media_url
      # @option props [String] :media_type
      # @option props [String] :media_width
      # @option props [String] :media_height
      # @example Create a new open graph object
      #
      # Yammer.create_open_graph_object('http://www.microsoft.com', {
      #  :site_name => 'Microsoft'
      #  :image     => 'https://microsoft.com/global/images/test.jpg'
      # })
      def create_open_graph_object(url, props={})
        post("/api/v1/open_graph_objects", { :url => url, :properties => props })
      end

      # Subscribes the current user to the open graph object with the request id.
      # @see https://developer.yammer.com/
      # @api_path /api/v1/open_graph_objects/
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Integer] id The ID of the open graph object
      # @example Subscribe to open graph object
      #
      # => Yammer.follow_open_graph_object(8)
      def follow_open_graph_object(id)
        post('/api/v1/subscriptions', :target_id => id, :target_type => 'OpenGraphObject')
      end

      # Determines if the current user follows an open graph object
      # @see https://developer.yammer.com/
      # @api_path /api/v1/open_graph_objects/
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Integer] id The ID of the open graph object
      # @example Verify to open graph object
      #
      # => Yammer.following_open_graph_object?(89)
      def is_following_open_graph_object?(id)
        get("/api/v1/subscriptions/to_open_graph_object/#{id}")
      end


      # Returns open graph objects in a user's activity stream
      # @see https://developer.yammer.com/
      # @api_path /api/v1/streams/activities
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param [Integer] id The ID of the users whose stream of open graph objects we want to fetch
      # @example Get open graph object in a given user's activity stream
      #
      #  Yammer.get_activity_stream_open_graph_objects?(3)
      def get_activity_stream_open_graph_objects(id)
        get("/api/v1/streams/activities", :owner_type => 'open_graph_object', :owner_id => id)
      end
    end
  end
end
