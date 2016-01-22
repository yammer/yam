# Copyright (c) Microsoft Corporation
# All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 
#
# THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR 
# CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING 
# WITHOUT LIMITATION ANY IMPLIED WARRANTIES OR CONDITIONS OF TITLE,
# FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABLITY OR NON-INFRINGEMENT. 

# See the Apache Version 2.0 License for specific language governing
# permissions and limitations under the License.

require 'oauth2-client'

module Yammer
  class OAuth2Client < OAuth2Client::Client

    SITE_URL       = 'https://www.yammer.com'
    TOKEN_PATH     = '/oauth2/access_token'
    AUTHORIZE_PATH = '/oauth2/authorize'

    def initialize(client_id, client_secret, opts={})
      site_url = opts.delete(:site_url) || SITE_URL
      opts[:token_path]     ||= TOKEN_PATH
      opts[:authorize_path] ||= AUTHORIZE_PATH
      super(site_url, client_id, client_secret, opts)
      yield self if block_given?
      self
    end

    # Generates the Yammer URL that the user will be redirected to in order to
    # authorize your application
    #
    # @see https://developer.yammer.com/v1.0/docs/oauth-2#client-side-flow
    #
    # @opts [Hash] additional parameters to be include in URL eg. scope, state, etc
    #
    # >> client = Yammer::OAuth2Client.new('ETSIGVSxmgZitijWZr0G6w', '4bJZY38TCBB9q8IpkeualA2lZsPhOSclkkSKw3RXuE')
    # >> client.webclient_authorization_url({
    #      :redirect_uri => 'https://localhost/oauth/cb',
    #    })
    # >> https://www.yammer.com/oauth2/authorize/?client_id={client_id}&
    #    redirect_uri=http%3A%2F%2Flocalhost%2Foauth%2Fcb&response_type=token
    #
    def webclient_authorization_url(opts={})
      implicit.token_url(opts)
    end

    # Generates the Yammer URL that the user will be redirected to in order to
    # authorize your application
    #
    # @see https://developer.yammer.com/v1.0/docs/oauth-2#server-side-flow
    #
    # @opts [Hash] additional parameters to be include in URL eg. scope, state, etc
    #
    # >> client = Yammer::OAuth2Client.new('ETSIGVSxmgZitijWZr0G6w', '4bJZY38TCBB9q8IpkeualA2lZsPhOSclkkSKw3RXuE')
    # >> client.webserver_authorization_url({
    #      :redirect_uri => 'https://localhost/oauth/cb',
    #    })
    # >> https://www.yammer.com/oauth2/authorize/?client_id={client_id}&
    #    redirect_uri=http%3A%2F%2Flocalhost%2Foauth%2Fcb&response_type=code
    #
    def webserver_authorization_url(opts={})
      opts[:scope] = normalize_scope(opts[:scope]) if opts[:scope]
      authorization_code.authorization_url(opts)
    end

    # Makes a request to Yammer server that will swap your authorization code for an access
    # token
    #
    # @see https://developer.yammer.com/v1.0/docs/oauth-2#server-side-flow
    #
    # @opts [Hash] may include redirect uri and other query parameters
    #
    # >> client = YammerClient.new(config)
    # >> client.access_token_from_authorization_code('G3Y6jU3a', {
    #      :redirect_uri => 'https://localhost:3000/oauth/v2/callback',
    #    })
    #
    # POST /oauth2/access_token HTTP/1.1
    # Host: www.yammer.com
    # Content-Type: application/x-www-form-urlencoded

    #  client_id={client_id}&code=G3Y6jU3a&grant_type=authorization_code&
    #  redirect_uri=http%3A%2F%2Flocalhost%2Foauth%2Fcb&client_secret={client_secret}
    def access_token_from_authorization_code(code, opts={})
      opts[:authenticate] ||= :body
      authorization_code.get_token(code, opts)
    end

    # Makes a request to Yammer server that will swap client credential for an access token
    #
    # @opts [Hash] parameters that will be added to URL query string
    #
    # >> client = Yammer::OAuth2Client.new('ETSIGVSxmgZitijWZr0G6w', '4bJZY38TCBB9q8IpkeualA2lZsPhOSclkkSKw3RXuE')
    # >> client.access_token_from_client_credentials({
    #      :client_id     => "ZitijWZr0",
    #      :client_secret => "F8TCBB9q8IpkeualA2lZsPhOSc"
    # })
    #      
    # POST /oauth2/access_token HTTP/1.1
    # Host: www.yammer.com
    # Content-Type: application/x-www-form-urlencoded
    #
    # client_id={client_id}&client_secret={client_secret}
    def access_token_from_client_credentials(opts={})
      opts[:authenticate] ||= :body
      client_credentials.get_token(opts)
    end

    # Makes a request to Yammer server that will swap resource owner credentials for an access token
    #
    # @opts [Hash] parameters that will be added to URL query string
    #
    # >> client = Yammer::OAuth2Client.new('ETSIGVSxmgZitijWZr0G6w', '4bJZY38TCBB9q8IpkeualA2lZsPhOSclkkSKw3RXuE')
    # >> client.access_token_from_client_credentials({
    #      :client_id     => "ZitijWZr0",
    #      :client_secret => "F8TCBB9q8IpkeualA2lZsPhOSc",
    #      :email => "user@domain.com",
    #      :password => "abc123"
    # })
    #
    # POST /oauth2/access_token HTTP/1.1
    # Host: www.yammer.com
    # Content-Type: application/x-www-form-urlencoded
    #
    # client_id={client_id}&client_secret={client_secret}&username={username}&password={passwort}
    def access_token_from_resource_owner_credentials(username, password, opts={})
      opts[:authenticate] ||= :body
      self.password.get_token(username, password, opts)
    end
  end
end
