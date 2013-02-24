Yam
===

[![Code Climate](https://codeclimate.com/github/yammer/yam.png)](https://codeclimate.com/github/yammer/yam)
[![Build Status](https://travis-ci.org/yammer/yam.png?branch=master)](https://travis-ci.org/yammer/yam)


The official Yammer Ruby gem.

NOTE: Currently in alpha - use at your own risk

Installation
------------

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

General Configuration
---------------------

The Yammer API requires you to authenticate via OAuth, so you'll need to register your Yammer application. To register a new application, sign in to Yammer and then fill out the form at https://www.yammer.com/client_applications.

If you already have your access token, you can skip this section.

To retrieve your access token, follow these steps.

1. Construct the following URL using the client_id you received after registering your app with Yammer: <https://www.yammer.com/dialog/oauth?client_id=[:client_id]>

2. Follow the URL you constructed above. It will take you to a Yammer OAuth dialog. Click the "Allow" button.

3. You will be redirected to a URL that looks something like this: <http://[:redirect_uri]?code=[:code]>

4. Use the code from step 3 along with your client_id and client_secret (obtained when registering your app) to construct the following URL:
<https://www.yammer.com/oauth2/access_token.json?client_id=[:client_id]&client_secret=[:client_secret]&code=[:code]>

5. The authorization server will return an access token object as part of a broader response that includes user profile information.

Sample access token (token is 'abcdefghijklmn' in this example) as part of response:

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

Set the OAuth token when creating a Yam instance. For example:

```ruby
access_token = 'abcdefghijklmn'
yammer_endpoint = 'https://www.yammer.com/api/v1/'
yam = Yam.new(access_token, yammer_endpoint)
```

Set up Yammer OAuth 2.0
-----------------------

See Yammer's Developer Guide for step-by-step instructions on setting up OAuth 2.0: <http://developer.yammer.com/files/2012/10/PlatformDeveloperGuide.pdf>

Usage Examples
--------------

All examples require an authenticated Yammer client. See the <a
href="#general-configuration">general configuration</a> section for instructions for finding and setting your access token.

For a list of all Yammer API endpoints, see the <a href="http://developer.yammer.com/restapi/">REST API documentation</a>.

Wherever you like, create an instance of the Yam client (optionally, memoized it for reuse):

yam ||= Yam.new('abcdefghijklmn', 'https://www.yammer.com/api/v1/')

Call methods on the instance like so:

**Find a Yammer user by email**

```ruby
yam.get('/users/by_email', email: 'user@example.com')
```

**Find a Yammer user by the Yammer user id**

```ruby
yam.get('/users/123456')
```

**Post a status update from the current user**

```ruby
yam.post('/messages', body: 'status update')
```

**Send a private message to another Yammer user**

```ruby
yam.post('/messages', body: 'this is a private message', direct_to_id: 123456)
```

**Send a private message to a Yammer group**

```ruby
yam.post('/messages', body: 'this is a group message', group_id: 987654)
```

**Send a message with an Open Graph Object as an attachment**

```ruby
yam.post('/messages', :body: 'here is my open graph object', og_url: "https://www.yammer.com/example/graph/123456789")
```

Contributing
------------

To contribute to this project, see the [CONTRIBUTING.md](https://github.com/yammer/yam/blob/master/CONTRIBUTING.md) file.
