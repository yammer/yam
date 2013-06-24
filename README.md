Yam
=============
[gemversion]: (http://badge.fury.io/rb/yam)
[travis]: (https://travis-ci.org/yammer/yam)
[coveralls]: (https://coveralls.io/r/yammer/yam)
[codeclimate]: (https://codeclimate.com/github/yammer/yam)

[![Gem Version](https://badge.fury.io/rb/yam.png)][gemversion]
[![Build Status](https://travis-ci.org/yammer/yam.png?branch=master)][travis]
[![Coverage Status](https://coveralls.io/repos/yammer/yam/badge.png)][coveralls]
[![Code Climate](https://codeclimate.com/github/yammer/yam.png)][codeclimate]


A Yammer Ruby gem

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

Setup a Yammer client application as described in [Build your first Yammer App](https://developer.yammer.com/introduction/)

### Obtaining an access token

1. Construct the following URL using the client_id you received `https://www.yammer.com/dialog/oauth?client_id=[:client_id]`

2. Have your users follow the URL you constructed above to allow your application to access their data 

3. After allowing access, your users will be redirected to your callback URL `http://[:redirect_uri]?code=[:code]`

4. Exchange the code for an access token by making an HTTP GET request to `https://www.yammer.com/oauth2/access_token.json?client_id=[:client_id]&client_secret=[:client_secret]&code=[:code]`

5. The authorization server will respond with an access token

```
"access_token": {
  "view_subscriptions": true,
  "expires_at": null,
  authorized_at": "2011/04/06 16:25:46 +0000",
  "modify_subscriptions": true,
  "modify_messages": true,
  "network_permalink": "yammer-inc.com",
  "view_members": true,
  "view_tags": true,
  "network_id": 155465488,
  "user_id": 1014216,
  "view_groups": true,
  "token": "abcdefghijklmn",
  "network_name": "Yammer",
  "view_messages": true,
  "created_at": "2011/04/06 16:25:46 +0000"
}
```

### Configuring yammer-client

To view the current state of the client use the `options` method

```ruby
require 'yammer'

Yammer.options
#> {:site_url=>"https://www.yammer.com", :client_id=>nil, :client_secret=>nil, :access_token=>nil, :http_adapter=>Yammer::Connection, :connection_options=>{:max_redirects=>5, :use_ssl=>true}} 
```

You may change this configuration by using the `configure` method

```ruby
Yammer.configure do |c|
  c.client_id = '[client_id]'
  c.client_secret = '[client_secret]'
  c.token = '[access_token]'
end
#> Yammer 
```

At this point, your new settings will take effect

```ruby
Yammer.options
#> {:site_url=>"https://www.yammer.com", :client_id=>'[client_id]', :client_secret=>'[client_secret]', :access_token=>'[access_token]', :http_adapter=>Yammer::Connection, :connection_options=>{ :max_redirects=>5, :use_ssl=>true }} 
```

## Usage

 `yammer-client` provides two ways to access Yammer's API. One of these ways is by using HTTP helper methods on and instance of `Yammer::Client`. The other 
 way is using methods on the object models that come bundled with this gem.

### Using the client

1. Create an instance of the Yammer client

```ruby
yamr = Yammer::Client.new(
        :client_id     => 'vAbMcg9qjgKsp4jjpm1pw',
        :client_secret => 'Wn0kp7Lu0TCY4GtZWkmSsqGErg10DmMADyjWkf2U',
        :access_token  => 'HqsKG3ka9Uls2DxahNi78A'
      )
```

2. Call methods on the instance:

**User**

*find a user by email*

```ruby
yamr.get_user_by_email('user@example.com')
#<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
```

*find a user by user id*

```ruby
yamr.get_user('1588')
#<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
```

*get the current user*

```ruby
yamr.current_user
#<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
```


**Message**

*post a update as the current user*

```ruby
yamr.create_message('status update')
#<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
```

*send a private message to another Yammer user*

```ruby
yamr.create_message('private message', :direct_to_id => 24)
#<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
```

*send a message with an Open Graph Object as an attachment*

```ruby
yamr.create_message('here is my open graph object', :og_url => "https://www.yammer.com/example/graph/31415926")
#<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
```


**Search**

*search for a term within the context of current user*

```ruby
yamr.search(:search => 'thekev', :model_types => 'users;groups')
#<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
```

**Thread**

*fetch a thread with a given id*

```ruby
yamr.get_thread(42)
#<Yammer::ApiResponse:0x007fb949434ec8 @headers=#<Net::HTTPOK 200 OK readbody=true>, @body="[JSON Response]", @code=200>
```


### Using the object models (Experimental)

The object model is an abstraction that makes it easy to manipulate the JSON data return when accessing Yammer's API. Each model has accessor methods for all keys contained in the JSON response for a given model type. 


**User**

*get the current user*


```ruby
u = Yammer::User.current
#> <Yammer::User:0x007f9f4b0c39c8>

u.full_name
#> 'Kevin Mutyaba'

u.update!(:job_title => 'k0dR')
```


**Thread**

*fetch a thread with a given id*

```ruby
t = Yammer::Thread.get(3)
```

View the participants in the thread

```ruby
parts = t.participants
#> [{:type=>"user", :id=>18}, {:type=>"user", :id=>64}]
```

View the participants in the thread as user object models

```ruby
peepl = t.people
#> [#<Yammer::User:0x007f9f4c086630 @modified_attributes={}, @attrs={}, @new_record=false, @id=18>, #<Yammer::User:0x007f9f4c086568 @modified_attributes={}, @attrs={}, @new_record=false, @id=64>] 
```

Object models are lazyly loaded. Calling an accessor on a model will hydrate it

```ruby
peepl[0]
#> #<Yammer::User:0x007f9f4c086568 @modified_attributes={}, @attrs={}, @new_record=false, @id=18> 

peepl[0].permalink
#> 'thekev'

peepl[0]
#=> #<Yammer::User:0x007f9f4c086568 @modified_attributes={}, @attrs={:last_name=>"Mutyaba", :network_id=>1, :first_name=>"Kevin", :id => 18,  :permalink=>"thekev" }, @network_id=1, @first_name="Kev", @full_name="Tiaba", @permalink="thekev", @id=18 > 
```

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
version:

* Ruby 1.8.7
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
