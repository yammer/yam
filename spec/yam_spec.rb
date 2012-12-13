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

require 'spec_helper'

class TestClass
end

describe Yam do
  # after do
  #   Yam.set_defaults
  # end

  ENDPOINT = Yam::Configuration::DEFAULT_API_ENDPOINT

  it 'responds to \'new\' message' do
    Yam.should respond_to :new
  end

  it 'receives \'new\' and initialize an instance' do
    access_token = 'ABC123'

    instance = Yam.new(access_token, ENDPOINT)

    instance.should be_a Yam::Client
  end

  it 'delegates to a Yam::Client instance' do
    access_token = 'ABC123'
    Yam::Client.any_instance.stubs(:stubbed_method)

    instance = Yam.new(access_token, ENDPOINT)
    instance.stubbed_method

    Yam::Client.any_instance.should have_received(:stubbed_method)
  end

  describe 'setting configuration options' do
    it 'returns the default adapter' do
      adapter = Yam.adapter

      adapter.should == Yam::Configuration::DEFAULT_ADAPTER
    end

    it 'allows setting the adapter' do
      Yam.adapter = :typhoeus

      Yam.adapter.should == :typhoeus
    end

    it 'returns the default end point' do
      Yam.endpoint.should == ENDPOINT
    end

    it 'allows setting the endpoint' do
      Yam.endpoint = 'http://www.example.com'
      Yam.endpoint.should == 'http://www.example.com'
    end

    it 'returns the default user agent' do
      Yam.user_agent.should == Yam::Configuration::DEFAULT_USER_AGENT
    end

    it 'allows setting the user agent' do
      Yam.user_agent = 'New User Agent'

      Yam.user_agent.should == 'New User Agent'
    end

    it 'allows setting the current api client' do
      Yam.should respond_to :api_client=
      Yam.should respond_to :api_client
    end
  end
end
