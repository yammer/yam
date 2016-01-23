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

describe Yammer::Api::Group do

  before :all do
    @client = Yammer::Client.new(
      :site_url     => 'https://www.yammer.com',
      :client_id     => 'PRbTcg9qjgKsp4jjpm1pw',
      :client_secret => 'Xn7kp7Ly0TCY4GtZWkmSsqGEPg10DmMADyjWkf2U',
      :access_token  => 'TolNOFka9Uls2DxahNi78A'
    )
  end

  subject { @client }

  describe '#all_groups' do
    it 'should fetch all groups in network' do
      expect(subject).to receive(:get).with('/api/v1/groups', {})
      subject.all_groups
    end
  end

  describe '#groups_for_user' do
    it 'should fetch all groups for user' do
      expect(subject).to receive(:get).with('/api/v1/groups/for_user/2')
      subject.groups_for_user(2)
    end
  end

  describe '#get_group' do
    it 'should fetch a thread' do
      expect(subject).to receive(:get).with('/api/v1/groups/1')
      subject.get_group(1)
    end
  end

  describe '#create_group' do
    it 'should fetch a thread' do
      expect(subject).to receive(:post).with('/api/v1/groups', {
        :name => 'my group',
        :description => 'A test group',
        :private => false
      })
      subject.create_group(:name => 'my group', :description => 'A test group', :private => false)
    end
  end

  describe '#update_group' do
    it 'should fetch a thread' do
      expect(subject).to receive(:post).with('/api/v1/groups/2', {
        :name => 'another group',
        :description => 'A modified group description',
      })
      subject.update_group(2, :name => 'another group', :description => 'A modified group description')
    end
  end
end
