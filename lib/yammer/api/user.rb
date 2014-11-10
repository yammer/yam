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
    module User

      # @see https://developer.yammer.com/restapi/#rest-users
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param  opts [Hash] A customizable set of options.
      # @option opts [String] :email
      # @option opts [String] :full_name
      # @option opts [String] :guid 
      # @option opts [String] :job_title
      # @option opts [String] :location
      # @option opts [String] :im_provider
      # @option opts [String] :im_username
      # @option opts [String] :work_telephone
      # @option opts [String] :work_extension
      # @option opts [String] :mobile_telephone
      # @option opts [String] :external_profiles
      # @option opts [String] :significant_other
      # @option opts [String] :kids_names
      # @option opts [String] :interests
      # @option opts [String] :summary
      # @option opts [String] :expertise
      # @option opts [String] :schools_csv
      # @option opts [String] :previous_companies_csv
      # @option opts [String] :preferred_my_feed
      # @option opts [String] :sticky_my_feed
      # @option opts [String] :prescribed_my_feed
      # @example create a user with the email `thekev@yammer.com`
      #   Yammer.create_user('thekev@yammer.com')
      def create_user(opts={})
        post("/api/v1/users", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-users
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param  opts [Hash] A customizable set of options.
      # @option opts [String] :email
      # @option opts [String] :full_name
      # @option opts [String] :guid 
      # @option opts [String] :job_title
      # @option opts [String] :location
      # @option opts [String] :im_provider
      # @option opts [String] :im_username
      # @option opts [String] :work_telephone
      # @option opts [String] :work_extension
      # @option opts [String] :mobile_telephone
      # @option opts [String] :external_profiles
      # @option opts [String] :significant_other
      # @option opts [String] :kids_names
      # @option opts [String] :interests
      # @option opts [String] :summary
      # @option opts [String] :expertise
      # @option opts [String] :schools_csv
      # @option opts [String] :previous_companies_csv
      # @option opts [String] :preferred_my_feed
      # @option opts [String] :sticky_my_feed
      # @option opts [String] :prescribed_my_feed
      # @example update info for a user with the email `thekev@yammer.com`
      #   Yammer.update_user(1, :job_title => 'software engineer')
      def update_user(id, opts={})
        put("/api/v1/users/#{id}", opts)
      end

      # @see https://developer.yammer.com/restapi/#rest-users
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer, String] A Yammer user ID
      # @example Delete user with ID 2
      #   Yammer.delete_user(2)
      def delete_user(id)
        delete("/api/v1/users/#{id}")
      end

      # @see https://developer.yammer.com/restapi/#rest-users
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param id [Integer, String] A Yammer user ID
      # @example Fetch data user with ID 2
      #   Yammer.get_user(2)
      def get_user(id)
        get("/api/v1/users/#{id}")
      end

      # @see https://developer.yammer.com/restapi/#rest-users
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param email [Integer, String] A Yammer user ID
      # @example Fetch data user with email `thekev@yammer.com`
      #   Yammer.get_user_by_email('thekev@yammer.com')
      def get_user_by_email(email)
        get("/api/v1/users/by_email", :email => email)
      end

      # @see https://developer.yammer.com/restapi/#rest-users
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @example Fetch data for the authenticated user
      #   Yammer.current_user
      def current_user
        get("/api/v1/users/current")
      end

      # @see https://developer.yammer.com/restapi/#rest-users
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param  opts [Hash] A customizable set of opts.
      # @option opts [Integer] :page
      # @example Fetch users from the authenticated user's network
      #   Yammer.all_users
      def all_users(opts={})
        get("/api/v1/users", opts)
      end

      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param  id [Integer] the ID of the user whose followers you want to get
      # @example Fetch users from the authenticated user's network following user whose ID is provided
      #   Yammer.users_following(1)
      def users_following(id)
        get("/api/v1/users/following/#{id}")
      end

      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param  id [Integer] the ID of the user for whom you want to get the users being followed
      # @example Fetch users from the authenticated user's network followed by the user whose ID is provided
      #   Yammer.users_followed(1)
      def users_followed_by(id)
        get("/api/v1/users/followed_by/#{id}")
      end

      # @rate_limited Yes
      # @authentication Requires user context
      # @raise  [Yammer::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Yammer::ApiResponse]
      # @param  id [Integer] the ID of the group for which you want to get the members of
      # @param  opts [Hash] A customizable set of opts.
      # @option opts [Integer] :page
      # @example Fetch users in a group that the authenticated user is in
      #   Yammer.users_in_group(1)
      def users_in_group(id, opts={})
        get("/api/v1/users/in_group/#{id}", opts)
      end
    end
  end
end
