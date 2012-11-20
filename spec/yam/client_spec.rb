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
#
require 'spec_helper'

describe Yam::Client, '#get' do
  it 'makes requests' do
    stub_get('/custom/get')
    subject.get('/custom/get')
    expect(a_get('/custom/get')).to have_been_made
  end
end

describe Yam::Client, '#post' do
  it 'makes requests' do
    stub_post('/custom/post')
    subject.post('/custom/post')
    expect(a_post('/custom/post')).to have_been_made
  end

  it 'makes authorized requests' do
    access_token = '123'
    Yam.oauth_token = access_token
    stub_post("/custom/post?access_token=#{access_token}")
    subject.post('/custom/post')
    expect(a_post("/custom/post?access_token=#{access_token}")).to have_been_made
  end
end
