Yam
=============

[![Gem Version](https://badge.fury.io/rb/yam.png)](http://badge.fury.io/rb/yam)
[![Build Status](https://travis-ci.org/yammer/yam.png?branch=master)](https://travis-ci.org/yammer/yam)
[![Coverage Status](https://coveralls.io/repos/yammer/yam/badge.png)](https://coveralls.io/r/yammer/yam)
[![Code Climate](https://codeclimate.com/github/yammer/yam.png)](https://codeclimate.com/github/yammer/yam)
<!-- [![Dependency Status](https://gemnasium.com/tiabas/yammer-oauth2.png)](https://gemnasium.com/yammer/yam)
 -->

The Yammer Ruby gem

## Documentation

This README provides only a basic overview of how to use this gem.For more information about the API endpoints and helper methods available, look at the rdoc documentation.

[http://rdoc.info/github/yammer/yam][documentation]

[documentation]: http://rdoc.info/github/yammer/yam/index 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yam'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install yam
```

## Configuration

The Yammer API requires authentication for access to certain endpoints. Below are the basic steps to get this done.

### Register your application

Setup a Yammer client application as described on the [Yammer Developer site](https://developer.yammer.com/introduction/)

### Obtaining an access token

1. Construct the following GET request using the client_id you received ``


```ruby
  GET https://www.yammer.com/oauth2/authorize?client_id=[:client_id]&response_type=code
```

2. Have your users follow the URL you constructed above to allow your application to access their data 

3. After allowing access, your users will be redirected to your callback URL `http://[:redirect_uri]?code=[:code]`

4. Exchange the code for an access token by making a POST request to Yammer

```ruby
  POST /oauth2/access_token.json HTTP/1.1
  Host: www.yammer.com
  Content-Type: application/x-www-form-urlencoded
  
    client_id=[:client_id]
    client_secret=[:client_secret]
    code=[:code]
    redirect_uri=https://example.com/oauth2/callback
    grant_type=authorization_code
```

5. The authorization server will respond with an access token

```ruby
"access_token": {
  ...
  "token": "abcxyz12345",
  ...
}
```

### Using Yammer OAuth2 Client to obtain an access token
This gem comes bundled with an OAuth2 wrapper that makes provides convenience methods for getting through the OAuth2 flow

```ruby

require 'yammer'

yammer_client = Yammer::OAuth2Client.new('PRbTcg9qjgKsp4jjpm1pw', 'Xn7kp7Ly0TCY4GtZWkmSsqGEPg10DmMADyjWkf2U')

```

#### Authorization Grants
The client wraps around the creation of any given grant and passing in the parameters defined in the configuration
file. The supported grants include Authorization Code and Implicit. They are available via the `authorization_code` and `implicit` methods on a client object.

#### Authorization Code grant (Server-side authorization)

```ruby

# generate authorization url
auth_url = yammer_client.webserver_authorization_url
# => https://www.yammer.com/oauth2/authorize?client_id=PRbTcg9qjgKsp4jjpm1pw&response_type=code

# exchange authorization code for access token. we will get back a Net::HTTPResponse
response = yammer_client.access_token_from_authorization_code('11a0b0b64db56c30e2ef', { :redirect_uri => 'https://localhost/callback'})

response.inspect 
# => #<Net::HTTPOK:0x007ff8bc7c1200>

response.body
# => {
#      "access_token" : {
#                          "token": "e409f4272fe539166a77c42479de030e7660812a",
#                          "token_type" : "bearer"
#                       }
#    }"
```

#### Implicit Grant (Client-side authorization)
```ruby
authorization_url = yammer_client.webclient_authorization_url(:redirect_uri => 'http://localhost/oauth2/callback')
# => "https://www.yammer.com/oauth2/authorize/?client_id=PRbTcg9qjgKsp4jjpm1pw&redirect_uri=http%3A%2F%2Flocalhost%2Foauth%2Fcallback&response_type=token"
```

### Using Yammer API client to access REST endpoints  

#### Configuration

You can view the current state of the client using the `Yammer#options` method

```ruby
require 'yammer'

Yammer.options
#> {:site_url=>"https://www.yammer.com", :client_id=>nil, :client_secret=>nil, :access_token=>nil, :http_adapter=>Yammer::Connection, :connection_options=>{:max_redirects=>5, :use_ssl=>true}} 
```

To change the configuration parameters use the `configure` method

```ruby
Yammer.configure do |c|
  c.client_id = '[client_id]'
  c.client_secret = '[client_secret]'
end
#> Yammer 
```

At this point, your new settings will take effect.

```ruby
Yammer.options
#> {:site_url=>"https://www.yammer.com", :client_id=>'[client_id]', :client_secret=>'[client_secret]', :access_token=>nil, :http_adapter=>Yammer::Connection, :connection_options=>{ :max_redirects=>5, :use_ssl=>true }} 
```
Take note of the fact that the `access_token` is nil. This will need to be set and, in the next section, we will see how to do this.

## Usage

- This gem offers three ways to interact Yammer's API:
  - Calling methods on the Yammer i.e `Yammer`
  - Calling methods on an instance of `Yammer::Client`.
  - Calling methods on the custom object models (Experimental)

### Calling methods on the Yammer module 
In order for this to work, you will need to set up your access_token. This assumes that you already configured the client with your default options as was described above.

 ```ruby
# set up your access token
Yammer.configure do |c|
  c.access_token = '[access_token]'
end
#=> <Yammer: {:http_adapter=>Yammer::HttpAdapter, :client_secret=>"[client_secret]", :access_token=>"[access_token]", :site_url=>"https://www.yammer.com", :connection_options=>{:max_redirects=>5, :verify_ssl=>true}, :default_headers=>{"Accept"=>"application/json", "User-Agent"=>"Yammer Ruby Gem 0.1.8"}, :client_id=>"[client_id]"}>

# get the current user
Yammer.current_user
```

### Calling methods on an instance of Yammer::Client
NOTE: Use this if you wish to create multiple client instances with diffrent client_id, client_secret and access token.
If your application uses a single pair of client_id and client_secret credentials, you ONLY need to specify the access token 

- Create an instance of the Yammer client

```ruby
# create a client instance using the access token: HqsKG3ka9Uls2DxahNi78A
yamr = Yammer::Client.new(:access_token  => 'HqsKG3ka9Uls2DxahNi78A')


# create multiple clients, each using a different access token
client1 = Yammer::Client.new(:access_token  => 'fG4mhFDf2GUUptztU0Qo9g')

client2 = Yammer::Client.new(:access_token  => 'ruZy4vFYyTWqnx7adO9ow')

```

- Call methods on the instance:

  - **User**

    - *find a user by email*

    ```ruby
    yamr.get_user_by_email('user@example.com')
    #<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
    ```

    - *find a user by user id*

    ```ruby
    yamr.get_user('1588')
    #<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
    ```

    - *get the current user*

    ```ruby
    yamr.current_user
    #<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
    ```

  - **Message**

    - *post a update as the current user*

    ```ruby
    yamr.create_message('status update')
    #<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
    ```

    - *send a private message to another Yammer user*

    ```ruby
    yamr.create_message('private message', :direct_to_id => 24)
    #<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
    ```

    - *send a message with an Open Graph Object as an attachment*

    ```ruby
    yamr.create_message('here is my open graph object', :og_url => "https://www.yammer.com/example/graph/31415926")
    #<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
    ```


  - **Search**

    - *search for a term within the context of current user*

    ```ruby
    yamr.search(:search => 'thekev', :model_types => 'users;groups')
    #<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
    ```

  - **Thread**

    - *fetch a thread with a given id*

    ```ruby
    yamr.get_thread(42)
    #<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
    ```

  - **Activity**

    - *create and post an activity*

    ```ruby
    yamr.create_activity(
      activity: {
        actor: {
          name: 'John Doe',
          email: 'jdoe@yammer-inc.com'
        },
        action: 'create',
        object: {
          url: 'www.example.com',
          title: 'Example event name',
        },
        message: 'Posting activity',
        users: [{
          name: 'Example Invitee',
          email: 'example@yammer-inc.com'
        }]
      }
    )
    #<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
    ```


### Using the object models (Experimental)

The object model is an abstraction that makes it easy to manipulate the JSON data return when accessing Yammer's API. Each model has accessor methods for all keys contained in the JSON response for a given model type. 


  - **User**

    - *get the current user*


    ```ruby
    u = Yammer::Resources::User.current
    #> <Yammer::Resources::User:0x007f9f4b0c39c8>

    u.full_name
    #> 'Kevin Mutyaba'

    u.update!(:job_title => 'k0dR')
    ```


  - **Thread**

    - *fetch a thread with a given id*

    ```ruby
    t = Yammer::Resources::Thread.get(3)
    ```

    View the participants in the thread

    ```ruby
    parts = t.participants
    #> [{:type=>"user", :id=>18}, {:type=>"user", :id=>64}]
    ```

    View the participants in the thread as user object models

    ```ruby
    peepl = t.people
    #> [#<Yammer::Resources::User:0x007f9f4c086630 @modified_attributes={}, @attrs={}, @new_record=false, @id=18>, #<Yammer::Resources::User:0x007f9f4c086568 @modified_attributes={}, @attrs={}, @new_record=false, @id=64>] 
    ```

    Object models are lazyly loaded. Calling an accessor on a model will hydrate it

    ```ruby
    peepl[0]
    #> #<Yammer::Resources::User:0x007f9f4c086568 @modified_attributes={}, @attrs={}, @new_record=false, @id=18> 

    peepl[0].permalink
    #> 'thekev'

    peepl[0]
    #=> #<Yammer::Resources::User:0x007f9f4c086568 @modified_attributes={}, @attrs={:last_name=>"Mutyaba", :network_id=>1, :first_name=>"Kevin", :id => 18,  :permalink=>"thekev" }, @network_id=1, @first_name="Kev", @full_name="Tiaba", @permalink="thekev", @id=18 > 
    ```

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
version:

* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

## Copyright
Copyright (c) 2013 Microsoft Corporation
See [LICENSE][license] for details.
[license]: https://github.com/tiabas/yammer-client/blob/master/LICENSE.md
