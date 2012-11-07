module Yam
  module Configuration

    VALID_OPTIONS_KEYS = [
      :adapter,
      :oauth_token,
      :user_agent,
      :endpoint,
    ].freeze

    DEFAULT_ADAPTER = :net_http

    DEFAULT_OAUTH_TOKEN = nil

    DEFAULT_ENDPOINT = 'https://www.yammer.com/api/v1'.freeze

    DEFAULT_USER_AGENT = "Yam Ruby Gem #{Yam::VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

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
      self.adapter            = DEFAULT_ADAPTER
      self.oauth_token        = DEFAULT_OAUTH_TOKEN
      self.user_agent         = DEFAULT_USER_AGENT
      self.endpoint           = DEFAULT_ENDPOINT
      self
    end

  end
end
