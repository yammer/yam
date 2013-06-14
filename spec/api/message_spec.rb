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

describe Yammer::Api::Message do

  before :all do
    @client = Yammer::Client.new(
      :site_url     => 'https://www.yammer.com',
      :client_id     => 'PRbTcg9qjgKsp4jjpm1pw',
      :client_secret => 'Xn7kp7Ly0TCY4GtZWkmSsqGEPg10DmMADyjWkf2U',
      :access_token  => 'TolNOFka9Uls2DxahNi78A'
    )
  end

  subject { @client }

  describe '#all_messages' do
    context 'with options' do
      it 'should get_messages' do
        params = { :page => 1 }
        subject.should_receive(:get).with('/api/v1/messages', params)
        subject.all_messages(params)
      end
    end

    context 'without options' do
      it 'should return all messages viewable by a user' do
        subject.should_receive(:get).with('/api/v1/messages', {})
        subject.all_messages 
      end
    end
  end

  describe '#create_message' do
    it 'should create_message' do
      message = 'Greetings, we come in peace'
      subject.should_receive(:post).with('/api/v1/messages', :body => message)
      subject.create_message(message)
    end
  end

  describe '#message' do
    it 'should fetch a message' do
      subject.should_receive(:get).with('/api/v1/messages/3')
      subject.get_message(3)
    end
  end

  describe '#delete_message' do
    it 'should delete a message' do
      subject.should_receive(:delete).with('/api/v1/messages/4')
      subject.delete_message(4)
    end
  end

  describe '#messages_sent' do
    it 'should fetch messages sent by a user' do
      subject.should_receive(:get).with('/api/v1/messages/sent', {})
      subject.messages_sent
    end
  end

  describe '#messages_received' do
    it 'should fetch messages received by a user' do
      subject.should_receive(:get).with('/api/v1/messages/received', {})
      subject.messages_received
    end
  end

  describe '#private_messages' do
    it 'should fetch private messages' do
      subject.should_receive(:get).with('/api/v1/messages/private', {})
      subject.private_messages
    end
  end

  describe '#followed_messages' do
    it 'should fetch messages followed by a user' do
      subject.should_receive(:get).with('/api/v1/messages/following', {})
      subject.followed_messages
    end
  end

  describe '#messages_from_user' do
    it 'should fetch messages created by a user' do
      subject.should_receive(:get).with('/api/v1/messages/from_user/14', {})
      subject.messages_from_user(14)
    end
  end

  describe '#messages_about_topic' do
    it 'should fetch messages about a topic' do
      subject.should_receive(:get).with('/api/v1/messages/about_topic/19', {})
      subject.messages_about_topic(19)
    end
  end

  describe '#messages_in_group' do
    it 'should fetch messages in group' do
      subject.should_receive(:get).with('/api/v1/messages/in_group/26', {})
      subject.messages_in_group(26)
    end
  end

  describe '#messages_liked_by' do
    it 'should fetch messages liked by user' do
      subject.should_receive(:get).with('/api/v1/messages/liked_by/58', {})
      subject.messages_liked_by(58)
    end
  end

  describe '#messages_in_thread' do
    it 'should fetch messages in thread' do
      subject.should_receive(:get).with('/api/v1/messages/in_thread/97', {})
      subject.messages_in_thread(97)
    end
  end
end