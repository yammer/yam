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

describe Yammer::User do

  before :all do
    Yammer.configure do |conf|
      conf.access_token = 'TolNOFka9Uls2DxahNi78A'
    end
  end

  after :all do
    Yammer.reset!
  end

  context 'class methods' do

    subject { Yammer::User }

    describe '#create' do
      it 'creates a new user' do
        stub_request(:post, "https://www.yammer.com/api/v1/users").with(
          :body    => { :email => 'hacker@yammer-inc.com' },
          :headers => {
            'Accept'          => 'application/json',
            'Authorization'   => "Bearer #{Yammer.access_token}",
            'Content-Type'    => 'application/x-www-form-urlencoded',
            'User-Agent'      => "Yammer Ruby Gem #{Yammer::Version}"
          }
        ).to_return(
          :status => 201,
          :body => '',
          :headers => { 'Location' => 'https://www.yammer.com/api/v1/users/364'}
        )
        subject.create('hacker@yammer-inc.com')
      end
    end

   describe '#current' do
      it "should fetch authenticated user's data" do
        stub_request(:get, "https://www.yammer.com/api/v1/users/current").with(
          :headers => {
            'Accept'          => 'application/json',
            'Authorization'   => "Bearer #{Yammer.access_token}",
            'User-Agent'      => "Yammer Ruby Gem #{Yammer::Version}"
          }
        ).to_return(
          :status => 200,
          :body => fixture('user.json'),
          :headers => {}
        )
        subject.current
      end
    end
  end

  context 'new user object with id' do

    before :each do
      Yammer::User.identity_map.purge!
    end

    subject { Yammer::User.new(:id => 1) }

    describe "#id" do
      it 'returns id' do
        expect(subject.id).to eq 1
      end
    end

    describe "calling getter method" do
      it 'makes an http request and hydrates object' do
        stub_request(:get, "https://www.yammer.com/api/v1/users/1").with(
          :headers => {
            'Accept'          => 'application/json',
            'Authorization'   => "Bearer #{Yammer.access_token}",
            'User-Agent'      => "Yammer Ruby Gem #{Yammer::Version}"
          }
        ).to_return(
          :status => 200,
          :body => fixture('user.json'),
          :headers => {}
        )
        subject.full_name
      end
    end

    describe "creating duplicate object" do
      it 'retrieves data from identitymap' do
        user = Yammer::User.new(:id => 1)
        stub_request(:get, "https://www.yammer.com/api/v1/users/1").with(
          :headers => {
            'Accept'          => 'application/json',
            'Authorization'   => "Bearer #{Yammer.access_token}",
            'User-Agent'      => "Yammer Ruby Gem #{Yammer::Version}"
          }
        ).to_return(
          :status => 200,
          :body => fixture('user.json'),
          :headers => {}
        )
        expect(user.full_name).to eq 'John Smith'

        duplicate = Yammer::User.new(:id => 1)
        expect(duplicate.full_name).to eq 'John Smith'
      end
    end
  end

  context 'hydrated user object' do
    subject { Yammer::User.new(MultiJson.load(fixture('user.json'), :symbolize_keys => true)) }

    describe "#id" do
      it 'returns id' do
        expect(subject.id).to eq 2
      end
    end

    describe "#email" do
      it 'returns email addresses' do
        stub_request(:get, "https://www.yammer.com/api/v1/users/2").
         with(:headers => {
          'Accept'=>'application/json',
          'Authorization'=>"Bearer #{Yammer.access_token}",
          'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
        }).to_return(
          :status => 200,
          :body => fixture('user.json'),
          :headers => {}
        )
        expect(subject.email).to eq 'jsmith@yammer-inc.com'
      end
    end

    describe "#followers" do
      it 'returns users following user' do
        stub_request(:get, "https://www.yammer.com/api/v1/users/following/2").
         with(:headers => {
          'Accept'=>'application/json',
          'Authorization'=>"Bearer #{Yammer.access_token}",
          'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
        }).to_return(
          :status => 200,
          :body => fixture('users_following.json'),
          :headers => {}
        )
        subject.followers
      end
    end

    describe "#following" do
      it 'returns users followed by user' do
        stub_request(:get, "https://www.yammer.com/api/v1/users/followed_by/2").
         with(:headers => {
          'Accept'=>'application/json',
          'Authorization'=>"Bearer #{Yammer.access_token}",
          'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
        }).to_return(
          :status => 200,
          :body => fixture('users_followed.json'),
          :headers => {}
        )
        subject.following
      end
    end

    describe "#delete" do
      it 'deletes user' do
        stub_request(:delete, "https://www.yammer.com/api/v1/users/2").
         with(:headers => {
          'Accept'=>'application/json',
          'Authorization'=>"Bearer #{Yammer.access_token}",
          'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
        }).to_return(
          :status => 200,
          :body => '',
          :headers => {}
        )
        subject.delete!
      end
    end

    describe '#update' do
      context 'with id as an integer' do
        it 'updates user' do
          stub_request(:put, "https://www.yammer.com/api/v1/users/2").with(
            :body    => { :last_name => 'tiabas' },
            :headers => {
              'Accept'          => 'application/json',
              'Authorization'   => "Bearer #{Yammer.access_token}",
              'Content-Type'    => 'application/x-www-form-urlencoded',
              'User-Agent'      => "Yammer Ruby Gem #{Yammer::Version}"
            }
          ).to_return(
            :status => 200,
            :body => '',
            :headers => { 'Location' => 'https://www.yammer.com/api/v1/users/2'}
          )
          subject.update!(:last_name => 'tiabas')
        end
      end
    end
  end
end