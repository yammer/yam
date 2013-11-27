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
require 'yammer/resources/identity_map'

describe Yammer::Resources::IdentityMap do

  subject { Yammer::Resources::IdentityMap.new }
  
  after :each do
    subject.purge!
  end

  context 'after initialization' do
    describe '#size' do
      it 'should be zero' do
        expect(subject.size).to eq 0
      end
    end

    describe '#get' do
      context 'with string parameter' do
        it 'should return nil' do
          expect(subject.get(:key)).to eq nil
        end
      end

      context 'with symbol parameter' do
        it 'should return nil' do
          expect(subject.get('key')).to eq nil
        end
      end
    end
  end

  context 'with data' do
    describe '#put' do
      context 'with nil key' do
        it 'should throw exception' do
          expect { subject.put(nil, 'value') }.to raise_error(Yammer::Resources::IdentityMap::InvalidKeyError)
        end
      end

      context 'with empty string' do
        it 'should throw exception' do
          expect { subject.put('', 'value') }.to raise_error(Yammer::Resources::IdentityMap::InvalidKeyError)
        end
      end

      it 'should store new value' do
        subject.put('user_1', 'smith')
        expect(subject.size).to eq 1
        expect(subject.get('user_1')).to eq 'smith'
      end

      it 'should overwrite existing value' do
        subject.put('user_1', 'smith')
        subject.put('user_1', 'john')
        expect(subject.size).to eq 1
        expect(subject.get('user_1')).to eq 'john'
      end
    end

    describe '#get' do
      context 'with nil key' do
        it 'should throw exception' do
          expect(subject.get(nil)).to eq nil
        end
      end

      context 'with empty string' do
        it 'should throw exception' do
          expect(subject.get('')).to eq nil
        end
      end

      context 'with valid key' do
        it 'should return a value' do
          subject.put('user_1', 'smith')
        end
      end

      context 'with valid key and default value' do
        it 'should return default' do
          subject.put('user_1', 'smith')
          expect(subject.get('user_1', 'test')).to eq 'smith'
        end
      end

      context 'with invalid key and default value' do
        it 'should return default' do
          expect(subject.get('user_1', 'test')).to eq 'test'
        end
      end
    end
  end

  describe '#purge!' do
    before do
      subject.put('user_1', 'smith')
      subject.put('user_2', 'john')
    end

    it 'empties the map' do
      expect(subject.size).to eq 2
      subject.purge!
      expect(subject.size).to eq 0
    end
  end
end
