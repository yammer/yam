require "yam/version"
require "yam/configuration"
require "yam/client"

module Yam
  extend Configuration

  class << self

    # Handle for the client instance
    attr_accessor :api_client

    # Alias for Yam::Client.new
    #
    # @return [Yam::Client]
    def new(options = {}, &block)
      @api_client = Yam::Client.new(options, &block)
    end

    # Delegate to Yam::Client
    #
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
