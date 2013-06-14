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

describe Yammer::Thread do

  before :all do
    Yammer.configure do |conf|
      conf.access_token = 'TolNOFka9Uls2DxahNi78A'
    end
  end

  after :all do
    Yammer.reset!
  end

  subject { Yammer::GroupMembership }

  context 'existing public thread' do
    subject { Yammer::Thread.new(MultiJson.load(fixture("public_thread.json"), :symbolize_keys => true)) }

    describe "#id" do
      it 'returns id' do
        expect(subject.id).to eq 11
      end
    end

    describe "#first_reply" do
      it 'returns first_reply' do
        expect(subject.first_reply).to be_instance_of(Yammer::Message)
        expect(subject.first_reply.id).to eq 11
      end
    end

    describe "#last_reply" do
      it 'returns last_reply' do
        expect(subject.last_reply).to be_instance_of(Yammer::Message)
        expect(subject.last_reply.id).to eq 13
      end
    end

    describe "messages" do
      it 'makes an http request and hydrates object' do
        stub_request(:get, "https://www.yammer.com/api/v1/messages/in_thread/11").with(
          :headers => {
            'Accept'          => 'application/json',
            'Authorization'   => "Bearer #{Yammer.access_token}",
            'User-Agent'      => "Yammer Ruby Gem #{Yammer::Version}"
          }
        ).to_return(
          :status => 200,
          :body => fixture("messages_in_thread.json"),
          :headers => {:content_type => "application/json; charset=utf-8"}
        )

        stub_request(:get, "https://www.yammer.com/api/v1/messages/in_thread/11").
         with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Bearer', 'User-Agent'=>'Yammer Ruby Gem 0.1.5'}).
         to_return(:status => 200, :body => "", :headers => {})
        subject.messages 
      end
    end
  end

  context 'existing private thread' do
    subject { Yammer::Thread.new(MultiJson.load(fixture("private_thread.json"), :symbolize_keys => true)) }
    describe "people" do
      it 'makes an http request and hydrates object' do
        subject.people.each do |person|
          expect(person).to be_instance_of(Yammer::User)
        end
      end
    end
  end
end