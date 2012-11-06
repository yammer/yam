module Yam
  # Core class for api interface operations
  class API
    attr_reader *Configuration::VALID_OPTIONS_KEYS

    class_eval do
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        define_method "#{key}=" do |arg|
          self.instance_variable_set("@#{key}", arg)
          Yam.send("#{key}=", arg)
        end
      end
    end

    # Creates new API
    def initialize(options={}, &block)
      setup(options)
    end

    def setup(options={})
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
  end
end
