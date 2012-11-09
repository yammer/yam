require 'faraday'
require 'yam/constants'
require 'faraday_middleware/response/mashify'
require 'faraday_middleware/response/parse_json'
require 'faraday_middleware/request/oauth2'

module Yam
  module Connection
    extend self
    include Yam::Constants

    def default_options(options={})
      {
        headers: {
          ACCEPT           => 'application/json',
          ACCEPT_CHARSET   => 'utf-8',
          USER_AGENT       => user_agent
        },
        ssl: { verify: false },
        url: options.fetch(:endpoint) { Yam.endpoint }
      }.merge(options)
    end

    # Returns a Faraday::Connection object
    #
    def connection(options = {})
      conn_options = default_options(options)
      clear_cache unless options.empty?
      puts "OPTIONS:#{conn_options.inspect}" if ENV['DEBUG']

      @connection ||= Faraday.new(conn_options) do |conn|
        conn.use Faraday::Response::Mashify
        conn.use FaradayMiddleware::ParseJson
        conn.response :raise_error

        if oauth_token?
          conn.use FaradayMiddleware::OAuth2, oauth_token
        end

        conn.request  :url_encoded
        conn.adapter adapter
      end
    end
  end
end
