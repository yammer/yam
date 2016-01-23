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

describe Yammer::Client do

  before :each do
    @configuration = {
      :site_url      => 'https://www.yammer.com',
      :client_id     => 'PRbTcg9qjgKsp4jjpm1pw',
      :client_secret => 'Xn7kp7Ly0TCY4GtZWkmSsqGEPg10DmMADyjWkf2U',
      :access_token  => 'TolNOFka9Uls2DxahNi78A',
      :connection_options => { :max_redirects => 5, :use_ssl => true },
      :default_headers    => {"Accept"=>"application/json", "User-Agent"=>"Yammer Ruby Gem #{Yammer::Version}"}
    }

    Yammer.configure do |config|
      @configuration.each do |key, val|
        config.send("#{key}=", val)
      end
    end
  end

  after :each do
    Yammer.reset!
  end

  subject { Yammer::Client.new(@configuration) }

  context "with module configuration" do

    before :each do
      @default_conf = {
        :site_url         => nil,
        :client_id        => nil,
        :client_secret    => nil,
        :access_token     => nil,
        :default_headers  => {"Accept"=>"application/json", "User-Agent"=>"Yammer Ruby Gem #{Yammer::Version}"},
        :connection_options => {}
      }
      Yammer.configure do |config|
        Yammer::Configurable.keys.each do |key|
          config.send("#{key}=", @default_conf[key])
        end
      end
    end

    after do
      Yammer.reset!
    end

    it "inherits the module configuration" do
      client = Yammer::Client.new
      @default_conf.each do |key, value|
        expect(client.instance_variable_get(:"@#{key}")).to eq value
      end
    end

    context "with initialization options" do
      before(:all) do
        @conf = {
          :site_url           => 'https://www.yammer.com',
          :client_id          => 'PRbTcg9qjgKsp4jjpm1pw',
          :client_secret      => 'Xn7kp7Ly0TCY4GtZWkmSsqGEPg10DmMADyjWkf2U',
          :access_token       => 'TolNOFka9Uls2DxahNi78A',
          :default_headers    => {"Accept"=>"application/json", "User-Agent"=>"Yammer Ruby Gem 0.1.1"},
          :connection_options => { :max_redirects => 5, :use_ssl => true }
        }
      end

      context "during initialization" do
        it "overrides the module configuration" do
          client = Yammer::Client.new(@conf)
          Yammer::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @conf[key]
          end
        end
      end

      context "after initialization" do
        it "overrides the module configuration" do
          Yammer.configure {|c| c.connection_options = {}}
          client = Yammer::Client.new
          client.configure do |config|
            @conf.each do |key, value|
              config.send("#{key}=", value)
            end
          end
          Yammer::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @conf[key]
          end
        end
      end
    end
  end



  describe "#connection_options" do
    context "with default connection options" do
      it "returns empty hash" do
        expect(subject.connection_options).to eq({ :max_redirects => 5, :use_ssl => true })
      end
    end

    context "with custom connection options" do
      it "returns default options" do
        subject.connection_options = { :max_redirects => 5, :use_ssl => true }
        expect(subject.connection_options).to eq({:max_redirects => 5, :use_ssl => true})
      end
    end
  end

  describe "#request" do
    context "when method is not supported" do
      it "raises an error" do
        subject.send(:request, :patch, '/')
      end
    end

    context "when method is get" do
      it "returns an http response" do
        path = '/oauth/authorize'
        params = {:client_id => '001337', :client_secret => 'abcxyz'}
        method = :get

        normalized_path = '/oauth/authorize?client_id=001337&client_secret=abcxyz'

        stub_request(:get, "https://www.yammer.com/oauth/authorize?client_id=001337&client_secret=abcxyz").with(
          :headers => {
            'Accept'=>'application/json',
            'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
        })
        response = subject.send(:request, method, path, params)

        expect(response.code).to eq 200
      end
    end

    context "when method is delete" do
      it "returns an http response" do
        path = '/users/1'

        stub_request(:delete, "https://www.yammer.com/users/1").with(
          :headers => {
            'Accept'=>'application/json',
            'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
          }).to_return(:status => 200, :body => "", :headers => {})

        response = subject.send(:request, :delete, path)
        expect(response.code).to eq 200
      end
    end

    context "when method is post" do
      it "returns an http response" do
        path = '/users'
        params = {:first_name => 'john', :last_name => 'smith'}
        query  = Addressable::URI.form_encode(params)
        headers = {'Content-Type' => 'application/x-www-form-urlencoded' }.merge(subject.default_headers)

        stub_request(:post, "https://www.yammer.com/users").with(
          :body => {
            "first_name"=>"john",
            "last_name"=>"smith"
            },
          :headers => {
            'Accept'=>'application/json',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
        }).to_return(:status => 200, :body => "", :headers => {})

        response =subject.send(:request, :post, path, params)
        expect(response.code).to eq 200
      end
    end

    context "when method is put" do
      it "returns an http response" do
        path = '/users/1'
        params = {:first_name => 'jane', :last_name => 'doe'}
        query  = Addressable::URI.form_encode(params)
        headers = {'Content-Type' => 'application/x-www-form-urlencoded' }.merge(subject.default_headers)

        stub_request(:put, "https://www.yammer.com/users/1").with(
          :body => {
            "first_name" => "jane",
            "last_name"  => "doe"
          },
          :headers => {
            'Accept'=>'application/json',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'Authorization'=>'Bearer TolNOFka9Uls2DxahNi78A',
            'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
          }).
         to_return(:status => 200, :body => "", :headers => {})

        response = subject.send(:request, :put, path, params)
        expect(response.code).to eq 200
      end
    end

    it "follows redirect" do
      params = {:first_name => 'jane', :last_name => 'doe'}
      stub_request(:post, "https://www.yammer.com/users").with(
        :body => params,
        :headers => {
          'Accept' =>'application/json',
          'Accept-Encoding' => 'gzip, deflate',
          'Content-Type'    => 'application/x-www-form-urlencoded',
          'User-Agent'      => "Yammer Ruby Gem #{Yammer::Version}"
        }
      ).to_return(:status => 303, :body => "", :headers => { 'Location' => 'https://www.yammer.com/members'})

      stub_request(:get, "https://www.yammer.com/members").
         with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"}).
         to_return(:status => 200, :body => "", :headers => {})
      response = subject.send(:request, :post, '/users', params)

      expect(response.code).to eq 200
    end

    it "respects the redirect limit " do
      subject.connection_options = { :max_redirects => 1 }

      stub_request(:get, "https://www.yammer.com/users").
         with(
          :headers => {
            'Accept' => 'application/json',
            'Accept-Encoding'=> 'gzip, deflate',
            'User-Agent'     => "Yammer Ruby Gem #{Yammer::Version}"
          }
        ).to_return(:status => 301, :body => "", :headers => { 'Location' => 'https://www.yammer.com/members'})


       stub_request(:get, "https://www.yammer.com/members").
         with(
          :headers => {
            'Accept' => 'application/json',
            'Accept-Encoding'=> 'gzip, deflate',
            'User-Agent'     => "Yammer Ruby Gem #{Yammer::Version}"
          }
        ).to_return(:status => 301, :body => "", :headers => { 'Location' => 'https://www.yammer.com/people'})

      expect { subject.send(:request, :get, '/users') }.to raise_error(RestClient::MaxRedirectsReached)
    end

    it "modifies http 303 redirect from POST to GET " do
      params = { :first_name => 'jane', :last_name => 'doe' }
      stub_request(:post, "https://www.yammer.com/users").with(
        :body => params,
        :headers => {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip, deflate',
          'Content-Length'=>'29',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
        }
      ).to_return(
        :status => 303,
        :body => "you are being redirected",
        :headers => {'Location' => "http://yammer.com/members"}
      )

      stub_request(:get, "http://yammer.com/members").
        with(
          :headers => {
            'Accept'=>'application/json',
            'Accept-Encoding'=>'gzip, deflate',
            'User-Agent'=> "Yammer Ruby Gem #{Yammer::Version}"
          }
      ).to_return(:status => 200, :body => "", :headers => {})

      response = subject.send(:request, :post, '/users', params )

      expect(response.code).to eq 200
    end
  end

  context 'http request' do
    describe "#post" do
      it "makes an http POST request" do
        stub_post('/users').with(
          :headers => {
            'Accept'=>'application/json',
            'Authorization'=>'Bearer TolNOFka9Uls2DxahNi78A',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'User-Agent'=>"Yammer Ruby Gem #{Yammer::Version}"
          },
          :body => { :name => 'alice' }).to_return({
            :status => 200, :body => "", :headers => {}
          })
        subject.post('/users', { :name => 'alice'})
      end
    end

    describe "#put" do
      it "makes an http PUT request" do
        stub_put('/users/1').with(
          :headers => {
            'Accept'=>'application/json',
            'Authorization'=>'Bearer TolNOFka9Uls2DxahNi78A',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'User-Agent'=> "Yammer Ruby Gem #{Yammer::Version}"
          },
          :body => { :name => 'bob' }).to_return(
            :status => 200, :body => "", :headers => {})

        subject.put('/users/1', { :name => 'bob'})
      end
    end

    describe "#get" do
      it "makes an http GET request" do
        stub_get('/users/1').with(:headers => { 'Authorization' => 'Bearer TolNOFka9Uls2DxahNi78A' })
        subject.get('/users/1')
      end
    end

    describe "#delete" do
      it "makes an http DELETE request" do
        stub_delete('/users/1').with(:headers => { 'Authorization' => 'Bearer TolNOFka9Uls2DxahNi78A' })
        subject.delete('/users/1')
      end
    end

    describe 'with invalid token' do
      it 'raises exception' do
        stub_get('/users/1').with(:headers => { 'Authorization' => 'Bearer TolNOFka9Uls2DxahNi78A' }).to_return(
          :body => '{ "response": { "message": "Token not found.", "code": 16, "stat": "fail" } }',
          :status => 401)

        expect(subject.get('/users/1')).to eq('{ "response": { "message": "Token not found.", "code": 16, "stat": "fail" } }')
      end
    end

    describe 'with too many requests' do
      it 'raises exception' do
        stub_get('/users/1').with(:headers => { 'Authorization' => 'Bearer TolNOFka9Uls2DxahNi78A' }).to_return(
          :body => '{ "response": { "message": "Rate limited due to excessive requests.", "code": 33, "stat": "fail" } }',
          :status => 429
        )
        expect(subject.get('/users/1')).to eq('{ "response": { "message": "Rate limited due to excessive requests.", "code": 33, "stat": "fail" } }')
      end
    end
  end
end
