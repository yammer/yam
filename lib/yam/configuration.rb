# encoding: utf-8

module Yam
  module Configuration

    VALID_OPTIONS_KEYS = [
      :oauth_token,
      :endpoint,
    ].freeze

    # By default, don't set a user oauth access token
    DEFAULT_OAUTH_TOKEN = nil

    # The api endpoint used to connect to GitHub if none is set
    DEFAULT_ENDPOINT = 'https://www.yammer.com'.freeze

    DEFAULT_USER_AGENT = "Yam Ruby Gem #{Yam::VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

    # Convenience method to allow for global setting of configuration options
    def configure
      yield self
    end

    def self.extended(base)
      base.set_defaults
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each { |k| options[k] = send(k) }
      options
    end

    def set_defaults
      self.oauth_token        = DEFAULT_OAUTH_TOKEN
      self.endpoint           = DEFAULT_ENDPOINT
      self
    end

  end # Configuration
end # Yam
