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

module Yammer
  module Resources
    class Base
      class << self
        include ApiHandler

        # Returns the non-qualified class name
        # @!scope class
        def base_name
          @base_name ||= begin
            word = "#{name.split(/::/).last}"
            word.gsub!(/::/, '/')
            word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
            word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
            word.tr!("-", "_")
            word.downcase!
            word
          end
        end

        # Fetches JSON reprsentation for object model with provided `id`
        # and returns a model instance with attributes
        # @return [Yammer::Base]
        # @param id [Integer]
        # @!scope class
        def get(id)
          attrs = fetch(id)
          attrs ? new(attrs) : nil
        end


        # @!scope class
        def fetch(id)
          return unless identity_map
          attributes = identity_map.get("#{base_name}_#{id}")
          unless attributes
            result = api_handler.send("get_#{base_name}", id)
            attributes = result.empty? ? nil : result.body
            unless attributes.empty?
              identity_map.put("#{base_name}_#{id}", attributes)
            end
          end
          attributes
        end

        # @!scope class
        def identity_map
          @identity_map ||= Yammer::Resources::IdentityMap.new
        end

        # Returns a hash of all attributes that are meant to trigger an HTTP request 
        # @!scope class
        def model_attributes
          @model_attributes ||= {}
        end

      protected

        def attr_accessor_deffered(*symbols)
          symbols.each do |key|
            # track attributes that should trigger a fetch
            model_attributes[key] = false

            # getter
            define_method(key.to_s) do
              load_deferred_attribute!(key)
              instance_variable_get("@#{key}")
            end

            # setter
            define_method("#{key}=") do |value|
              load_deferred_attribute!(key)
              if persisted? && loaded?
                @modified_attributes[key] = value
              else
                @attrs[key] = value
              end
              instance_variable_set("@#{key}", value)
            end
          end
        end
      end

      attr_reader :id, :attrs

      def initialize(props={})
        @klass               = self.class
        @modified_attributes = {}
        @new_record          = true
        @loaded              = false
        @attrs               = props
        self.id              = @attrs.delete(:id)
        self.update(@attrs)

        yield self if block_given?
      end

      def api_handler
        @klass.api_handler
      end

      def base_name
        @klass.base_name
      end

      def new_record?
        @new_record
      end

      def persisted?
        !new_record?
      end

      def changes
        @modified_attributes
      end

      def modified?
        !changes.empty?
      end

      def loaded?
        @loaded
      end

      def load!
        @attrs = @klass.fetch(@id)
        @loaded = true
        update(@attrs)
        self
      end

      def reload!
        reset!
        load!
      end

      def save
        return self if ((persisted? && @modified_attributes.empty?) || @attrs.empty?)

        result = if new_record?
          api_handler.send("create_#{base_name}", @attrs)
        else
          api_handler.send("update_#{base_name}", @id, @modified_attributes)
        end
        @modified_attributes = {}
        self
      end

      def delete!
        return if new_record?
        result = api_handler.send("delete_#{base_name}", @id)
        result.success?
      end

    private

      def id=(model_id)
        return if model_id.nil?
        @id = model_id.to_i
        @new_record = false
      end

      # clear the entire class
      def reset!
        @modified_attributes = {}
        @attrs  = {}
        @new_record = true
        @loaded = false
      end

    protected
      # loads model 
      def load_deferred_attribute!(key)
        if @attrs.empty? && persisted? && !loaded?
          load!
          if !@attrs.has_key?(key)
            raise "The key: #{key} appears not to be supported for model: #{self.base_name} \n #{@attrs.keys.inspect}"
          end
        end
      end

      # set all fetchable attributes 
      def update(attrs={})
        attrs.each do |key, value|
          send("#{key}=", value)
        end
        if persisted? && !loaded?
          @loaded = @klass.model_attributes.keys.inject(true) do |result, key|
            result && @attrs.has_key?(key)
          end
        end
      end
    end
  end
end