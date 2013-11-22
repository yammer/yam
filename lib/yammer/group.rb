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
  class Group < Yammer::Base

    attr_accessor_deffered :show_in_directory, :privacy, :description, :creator_type,
    :creator_id, :mugshot_id, :stats, :state, :web_url, :name, :created_at, :type,
    :mugshot_url, :url, :full_name, :mugshot_url_template, :description

    # @!scope class
    def self.create(params={})
      api_handler.create_group(params)
    end
  end
end
