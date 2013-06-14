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

describe Yammer::Error do

  subject { Yammer::Error }

  describe 'from status' do

    context 'status unknown' do
      it 'returns ApiError' do
        expect(subject.from_status).to eq Yammer::Error::ApiError
      end
    end

    context 'status 400' do
      it 'returns BadRequest' do
        expect(subject.from_status(400)).to eq Yammer::Error::BadRequest
      end
    end

    context 'status 401' do
      it 'returns Unauthorized' do
        expect(subject.from_status(401)).to eq Yammer::Error::Unauthorized 
      end
    end

    context 'status 403' do
      it 'returns Forbidden' do
        expect(subject.from_status(403)).to eq Yammer::Error::Forbidden
      end
    end 

    context 'status 404' do
      it 'returns NotFound' do
        expect(subject.from_status(404)).to eq Yammer::Error::NotFound
      end
    end

    context 'status 406' do
      it 'returns NotAcceptable' do
        expect(subject.from_status(406)).to eq Yammer::Error::NotAcceptable
      end
    end

    context 'status 429' do
      it 'returns RateLimitExceeded' do
        expect(subject.from_status(429)).to eq Yammer::Error::RateLimitExceeded
      end
    end

    context 'status 500' do
      it 'returns InternalServerError' do
        expect(subject.from_status(500)).to eq Yammer::Error::InternalServerError
      end
    end

    context 'status 502' do
      it 'returns BadGateway' do
        expect(subject.from_status(502)).to eq Yammer::Error::BadGateway
      end
    end

    context 'status 503' do
      it 'returns ServiceUnavailable' do
        expect(subject.from_status(503)).to eq Yammer::Error::ServiceUnavailable
      end
    end
  end
end