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

describe Yam::Client, '#get' do
  it 'makes requests' do
    access_token = 'ABC123'
    endpoint_with_token = "#{ENDPOINT}?access_token=#{access_token}"
    stub_request(:get, endpoint_with_token).
      with(:headers => { 'Authorization'=>'Token token="ABC123"' })

    instance = Yam::Client.new(access_token, ENDPOINT)
    instance.get('/')

    expect(a_request(:get, endpoint_with_token).
      with(:headers => { 'Authorization'=>'Token token="ABC123"' })).
      to have_been_made
  end
end

describe Yam::Client, '#post' do
  it 'makes requests' do
    access_token = 'ABC123'
    endpoint_with_token = "#{ENDPOINT}?access_token=#{access_token}"
    stub_request(:post, endpoint_with_token).
      with(:headers => { 'Authorization'=>'Token token="ABC123"' })

    instance = Yam::Client.new(access_token, ENDPOINT)
    instance.post('/')

    expect(a_request(:post, endpoint_with_token).
      with(:headers => { 'Authorization'=>'Token token="ABC123"' })).
      to have_been_made
  end
end
