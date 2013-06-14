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

require File.expand_path('../spec_helper', __FILE__)
require 'yammer/response'

describe Yammer::ApiResponse do

  context 'successful response' do
    subject do
      headers = { 'Location' => 'https://www.yammer.com/api/v1/messages/2' }
      body    = '{ "system_message":false, "direct_message":true, "id":10928508, "privacy":"private", "network_id":1 }'
      code    = '200'
      Yammer::ApiResponse.new(headers, body, code)
    end

    describe '#raw_body' do
      it 'returns a string' do
        expect(subject.raw_body).to eq('{ "system_message":false, "direct_message":true, "id":10928508, "privacy":"private", "network_id":1 }')
      end
    end

    describe '#body' do
      it 'return a hash' do
        expect(subject.body).to eq({ :system_message => false, :direct_message => true, :id => 10928508, :privacy => 'private', :network_id => 1 })
      end
    end

    describe '#success' do
      it 'returns true' do
        expect(subject.success?).to eq true
      end
    end

    describe '#created?' do
      it 'returns true' do
        expect(subject.created?).to eq false
      end
    end
  end

  context 'failed response' do

    subject { Yammer::ApiResponse.new(double( :headers => {}, :body   => '', :code   => '500')) }

    describe '#raw_body' do
      it 'returns a string' do
        expect(subject.raw_body).to eq('')
      end
    end

    describe '#body' do
      it 'return a hash' do
        expect(subject.body).to eq('')
      end
    end

    describe '#success' do
      it 'returns true' do
        expect(subject.success?).to eq false
      end
    end

    describe '#created?' do
      it 'returns true' do
        expect(subject.created?).to eq false
      end
    end
  end
end