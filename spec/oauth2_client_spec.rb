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

describe Yammer::OAuth2Client do

  subject do
    Yammer::OAuth2Client.new('PRbTcg9qjgKsp4jjpm1pw', 'a2nQpcUm2Dgq1chWdAvbXGTk', {
      :connection_options => {
        :headers => {
          'User-Agent' => "Yammer OAuth2 Client #{Yammer::Version}",
          "Accept"     => "application/json"
        }
      }
    })
  end

  describe "#webserver_authorization_url" do
    it "returns the authorization url" do
      params = {
        "client_id" => "PRbTcg9qjgKsp4jjpm1pw",
        "redirect_uri" => "https://localhost/callback",
        "response_type" =>"code",
        "state" => "12345"
      }

      auth_url = subject.webserver_authorization_url(
        :client_id => 'PRbTcg9qjgKsp4jjpm1pw',
        :state => '12345',
        :redirect_uri => 'https://localhost/callback'
      )

      parsed_url = Addressable::URI.parse(auth_url)
      expect(parsed_url.path).to eq '/oauth2/authorize'
      expect(parsed_url.query_values).to eq params
      expect(parsed_url.scheme).to eq 'https'
      expect(parsed_url.host).to eq 'www.yammer.com'
    end
  end

  describe "#access_token_from_authorization_code" do
    it "makes a POST request to exchange authorization code for access token" do

      stub_request(:post, "https://www.yammer.com/oauth2/access_token").with(
        :body => {
          :grant_type    => 'authorization_code',
          :code          => 'MmOGL795LbIZuJJVnL49Cc',
          :redirect_uri  => 'https://localhost',
          :client_id     => 'PRbTcg9qjgKsp4jjpm1pw',
          :client_secret => 'a2nQpcUm2Dgq1chWdAvbXGTk'
        },
        :headers => {
          'Accept'         =>'application/json',
          'Content-Type'   =>'application/x-www-form-urlencoded', 
          'User-Agent'     =>"Yammer OAuth2 Client #{Yammer::Version}"
      })

      subject.access_token_from_authorization_code(
        'MmOGL795LbIZuJJVnL49Cc',
        :params => {
          :redirect_uri => 'https://localhost'
        }
      )
    end
  end

  describe "#access_token_from_client_credentials" do
    it "makes a POST request to exchange client credentiaks for access token" do

      stub_request(:post, "https://www.yammer.com/oauth2/access_token").with(
        :body => {
          :grant_type    => 'client_credentials',
          :client_id     => 'PRbTcg9qjgKsp4jjpm1pw',
          :client_secret => 'a2nQpcUm2Dgq1chWdAvbXGTk'
        },
        :headers => {
          'Accept'         =>'application/json',
          'Content-Type'   =>'application/x-www-form-urlencoded', 
          'User-Agent'     =>"Yammer OAuth2 Client #{Yammer::Version}"
      })

      subject.access_token_from_client_credentials
    end
  end

  describe "#access_token_from_resource_owner_credentials" do
    it "makes a POST request to exchange client credentiaks for access token" do

      stub_request(:post, "https://www.yammer.com/oauth2/access_token").with(
        :body => {
          :grant_type    => 'password',
          :username      => 'thekev',
          :password      => 'h4x0r',
          :client_id     => 'PRbTcg9qjgKsp4jjpm1pw',
          :client_secret => 'a2nQpcUm2Dgq1chWdAvbXGTk'
        },
        :headers => {
          'Accept'         =>'application/json',
          'Content-Type'   =>'application/x-www-form-urlencoded', 
          'User-Agent'     =>"Yammer OAuth2 Client #{Yammer::Version}"
      })

      subject.access_token_from_resource_owner_credentials('thekev', 'h4x0r')
    end
  end
end