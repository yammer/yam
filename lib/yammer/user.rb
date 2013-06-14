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
  class User < Yammer::Base


    # Returns authenticated user's details
    # @!scope class
    def self.current
      result = api_handler.current_user
      return nil unless result.success?
      new(result.body)
    end

    # Creates a new user from email address
    # @!scope class
    def self.create(email)
      result = api_handler.create_user(:email => email)
      return nil unless result.created?
      id = result.headers[:location].split('/').last.to_i
      new(:id => id)
    end

    attr_accessor_deffered :first_name, :last_name, :full_name, :hire_date, :mugshot, :state,
    :type, :admin, :verified_admin, :expertise, :birth_date, :stats, :show_ask_for_photo, :job_title,
    :web_url, :url, :external_urls, :activated_at, :summary, :department, :previous_companies,
    :follow_general_messages, :schools, :interests, :significant_other, :network_name, :network_id,
    :can_broadcast, :web_preferences, :network_domains, :location, :contact, :kids_names, :guid,
    :name, :mugshot_url, :mugshot_url_template, :settings, :timezone

    # Returns user's primary email
    def email
      @email ||= begin
        self.contact[:email_addresses].map do |e|
          e[:address] if e[:type] == 'primary'
        end.first
      end
    end

    # Returns all users that this user is following
    def following
      api_handler.users_followed_by(@id)
    end

    # Returns all user's follwing this user
    def followers
      api_handler.users_following(@id)
    end

    # Updates the user attributes
    def update!(params)
      api_handler.update_user(@id, params)
    end
  end
end
