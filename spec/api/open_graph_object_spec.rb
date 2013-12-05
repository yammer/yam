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

require File.expand_path('../../spec_helper', __FILE__)

describe Yammer::Api::Search do

  before :all do
    @client = Yammer::Client.new(
      :site_url     => 'https://www.yammer.com',
      :client_id     => 'PRbTcg9qjgKsp4jjpm1pw',
      :client_secret => 'Xn7kp7Ly0TCY4GtZWkmSsqGEPg10DmMADyjWkf2U',
      :access_token  => 'TolNOFka9Uls2DxahNi78A'
    )
  end

  subject { @client }

  describe '#open graph object' do

    it 'should create open graph object' do
      ogo_url = 'http://www.example.com'
      ogo_props = {
        :site_name => 'Microsoft',
        :image     => 'https://example.com/global/images/test.jpg'
      }
      subject.should_receive(:post).with('/api/v1/open_graph_objects', {
        :url=>"http://www.example.com",
        :properties => {
          :site_name => "Microsoft",
          :image => "https://example.com/global/images/test.jpg"
        }
      })
      subject.create_open_graph_object(ogo_url, ogo_props)
    end

    it 'should follow open graph object' do
      subject.should_receive(:post).with('/api/v1/subscriptions', :target_id => 7, :target_type => 'OpenGraphObject')
      subject.follow_open_graph_object(7)
    end

    it 'should follow opnen graph object' do
      subject.should_receive(:get).with('/api/v1/subscriptions/to_open_graph_object/5')
      subject.is_following_open_graph_object?(5)
    end

    it 'should fetch open graph objects in user activity stream' do
      subject.should_receive(:get).with('/api/v1/streams/activities', :owner_type => 'open_graph_object', :owner_id => 4)
      subject.get_activity_stream_open_graph_objects(4)
    end
  end
end
