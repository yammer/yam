# Copyright (c) Microsoft Corporation
# All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY
# IMPLIED WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR
# PURPOSE, MERCHANTABLITY OR NON-INFRINGEMENT.
#
# See the Apache Version 2.0 License for specific language governing
# permissions and limitations under the License.

require 'simplecov'

SimpleCov.start do
  add_filter 'spec'
end

require 'bourne'
require 'rspec'
require 'webmock/rspec'
require 'yam'

ENDPOINT = Yam::Configuration::DEFAULT_API_ENDPOINT

RSpec.configure do |config|
  config.mock_with :mocha
  config.include WebMock::API
  config.order = :rand
  config.color_enabled = true

  config.before(:each) do
    Yam.set_defaults
  end
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, '/', file))
end
