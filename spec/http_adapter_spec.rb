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
require 'yammer/http_adapter'

describe Yammer::HttpAdapter do

  before :all do
    Yammer.configure do |conf|
      conf.access_token = 'TolNOFka9Uls2DxahNi78A'
    end
  end

  describe "#send_request" do
    context 'when resource is found' do
      subject { @conn = Yammer::HttpAdapter.new('https://www.yammer.com') }
      let(:uri) { 'https://www.yammer.com/foo' }
      before    { stub_request(:get, uri).to_return(status: 200, body: nil) }
      it "returns a Yammer APIResponse" do
        response = subject.send_request(:get, "/foo")
        expect(response).to be_a(Yammer::ApiResponse)
      end
    end

    context 'when resource is not found' do
      subject { @conn = Yammer::HttpAdapter.new('https://www.yammer.com') }
      let(:uri) { 'https://www.yammer.com/foo' }
      before    { stub_request(:get, uri).to_return(status: 404, body: nil) }
      it "returns a Yammer APIResponse" do
        response = subject.send_request(:get, "/foo")
        expect(response).to eq(Yammer::Error::NotFound)
      end
    end

    context 'when resource is unauthorized' do
      subject { @conn = Yammer::HttpAdapter.new('https://www.yammer.com') }
      let(:uri) { 'https://www.yammer.com/foo' }
      before    { stub_request(:get, uri).to_return(status: 401, body: nil) }
      it "returns a Yammer APIResponse" do
        response = subject.send_request(:get, "/foo")
        expect(response).to eq(Yammer::Error::Unauthorized )
      end
    end
  end

  context "initialization" do
    context "with user options" do

      before do
        @options = {
          :verify_ssl    => false,
          :max_redirects => 2
        }
      end

      subject { @conn = Yammer::HttpAdapter.new('https://www.example.com', @options) }

      it "overrides default options" do
        expect(subject.instance_variable_get(:"@connection_options")).to eq @options
      end
    end

    context "with invalid url" do
      it "should raise argument error" do
        expect { Yammer::HttpAdapter.new('www.example.com') }.to raise_error(ArgumentError)
      end
    end
  end

  context "with no options" do

    subject { @conn = Yammer::HttpAdapter.new('https://www.yammer.com') }

    describe "#scheme" do
      it "returns the http scheme" do
        expect(subject.scheme).to eq 'https'
      end
    end

    describe "#host" do
      it "returns the host server" do
        expect(subject.host).to eq 'www.yammer.com'
      end
    end

    describe "site_url" do
      it "returns site_url" do
        expect(subject.site_url).to eq 'https://www.yammer.com'
      end
    end

    describe "site_url=" do
      it "sets new site_url on client" do
        subject.site_url = 'https://www.elpmaxe.com'
        expect(subject.site_url).to eq 'https://www.elpmaxe.com'
      end
    end

    describe "connection_options=" do
      it "sets new connection_options" do
        subject.connection_options = { :max_redirects => 6 }
        expect(subject.connection_options).to eq({ :max_redirects => 6 })
      end

      it "should raise error" do
        expect { subject.connection_options = '' }.to raise_error(ArgumentError)
      end
    end

    describe "#absolute_url" do
      context "with no parameters" do
        it "returns a uri without path" do
          expect(subject.send(:absolute_url)).to eq "https://www.yammer.com"
        end
      end

      context "with parameters" do
        it "returns a uri with path" do
          expect(subject.send(:absolute_url, '/oauth/v2/authorize')).to eq "https://www.yammer.com/oauth/v2/authorize"
        end
      end
    end
  end
end
