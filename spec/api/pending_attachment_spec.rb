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

describe Yammer::Api::PendingAttachment do

  before :all do
    @client = Yammer::Client.new(
      :site_url     => 'https://www.yammer.com',
      :client_id     => 'PRbTcg9qjgKsp4jjpm1pw',
      :client_secret => 'Xn7kp7Ly0TCY4GtZWkmSsqGEPg10DmMADyjWkf2U',
      :access_token  => 'TolNOFka9Uls2DxahNi78A'
    )
  end

  subject { @client }

  describe '#get_pending_attachment' do
    it 'should fetch a pending attachment' do
      expect(subject).to receive(:get).with('/api/v1/pending_attachments/2')
      subject.get_pending_attachment(2)
    end
  end

  describe '#delete_pending_attachment' do
    it 'should delete a pending attachment' do
      expect(subject).to receive(:delete).with('/api/v1/pending_attachments/1')
      subject.delete_pending_attachment(1)
    end
  end

  describe '#create_pending_attachment' do
    it 'should create a pending attachment' do
      attachment = upload('attachment.txt')
      expect(subject).to receive(:post).with('/api/v1/pending_attachments', :attachment => attachment)
      subject.create_pending_attachment(attachment)
    end
  end
end