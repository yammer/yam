# API setup and configuration

require 'yam/request'
require 'yam/connection'
require 'yam/configuration'

module Yam
  class API
    include Connection
    include Request
    attr_reader *Configuration::VALID_OPTIONS_KEYS

    class_eval do
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        define_method "#{key}=" do |arg|
          self.instance_variable_set("@#{key}", arg)
          Yam.send("#{key}=", arg)
        end
      end
    end

    def initialize(options={}, &block)
      setup(options)
    end

    def setup(options={})
      options = Yam.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def method_missing(method, *args, &block)
      if method.to_s.match /^(.*)\?$/
        return !self.send($1.to_s).nil?
      end
    end
  end
end
