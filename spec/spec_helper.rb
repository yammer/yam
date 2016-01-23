# -*- encoding: utf-8 -*-

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
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require 'yammer'
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!(:allow => 'coveralls.io')

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def stub_delete(path='')
  stub_request(:delete, "https://www.yammer.com#{path}")
end

def stub_get(path='')
  stub_request(:get, "https://www.yammer.com#{path}")
end

def stub_post(path='')
  stub_request(:post, "https://www.yammer.com#{path}")
end

def stub_put(path='')
  stub_request(:put, "https://www.yammer.com#{path}")
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def mock_path
  File.expand_path("../mocks", __FILE__)
end

def fixture(file)
  File.new("#{fixture_path}/#{file}")
end

def upload(file)
  File.new("#{mock_path}/#{file}")
end
