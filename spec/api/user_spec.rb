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
require 'ostruct'

describe Yammer::Api::User do

  before :all do
    @client = Yammer::Client.new(
      :site_url     => 'https://yammer.com',
      :client_id     => 'PRbTcg9qjgKsp4jjpm1pw',
      :client_secret => 'Xn7kp7Ly0TCY4GtZWkmSsqGEPg10DmMADyjWkf2U',
      :access_token  => 'TolNOFka9Uls2DxahNi78A'
    )
  end

  subject { @client }

  describe 'all_users' do
    it 'makes an http request' do
      @client.should_receive(:get).with('/api/v1/users', { :page => 1, :letter => 'm' })
      @client.all_users({:page => 1, :letter => 'm'})
    end
  end

  describe 'create_user' do
    it 'makes an http request' do
      params = {:first_name => 'john', :last_name => 'doe', :email => 'jdoe@yammer-inc.com'}
      @client.should_receive(:post).with('/api/v1/users', params)
      @client.create_user(params)
    end
  end

  describe 'get_user' do
    it 'makes an http request' do
      @client.should_receive(:get).with('/api/v1/users/1')
      @client.get_user(1)
    end
  end

  describe 'update_user' do
    it 'makes an http request' do
      params = {:first_name => 'jane', :last_name => 'smith'}
      @client.should_receive(:put).with('/api/v1/users/1', params)
      @client.update_user(1, params)
    end

    context 'with id as a string' do
      it 'updates user' do
        params = {:first_name => 'jane', :last_name => 'smith'}
        @client.should_receive(:put).with('/api/v1/users/current', params)
        subject.update_user('current', params)
      end
    end
  end

  describe 'delete_user' do
    it 'makes an http request' do
      @client.should_receive(:delete).with('/api/v1/users/1')
      @client.delete_user(1)
    end
  end

  describe 'get_user_by_email' do
    it 'makes an http request' do
      @client.should_receive(:get).with('/api/v1/users/by_email', :email => 'bob@yammer-inc.com')
      @client.get_user_by_email('bob@yammer-inc.com')
    end
  end

  describe 'current_user' do
    it 'makes an http request' do
      @client.should_receive(:get).with('/api/v1/users/current')
      @client.current_user
    end
  end

  describe 'users_following' do
    it 'makes an http request' do
      @client.should_receive(:get).with('/api/v1/users/following/3')
      @client.users_following(3)
    end
  end

  describe 'users_followed_by' do
    it 'makes an http request' do
      @client.should_receive(:get).with('/api/v1/users/followed_by/4')
      @client.users_followed_by(4)
    end
  end
end
