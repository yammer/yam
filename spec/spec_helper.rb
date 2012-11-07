require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
end
require 'rspec'
require 'yam'
require 'webmock/rspec'
require 'bourne'

RSpec.configure do |config|
  config.mock_with :mocha
  config.include WebMock::API
  config.order = :rand
  config.color_enabled = true
  config.before(:each) do
    Yam.set_defaults
  end
end

def stub_post(path, endpoint = Yam.endpoint.to_s)
  stub_request(:post, endpoint + path)
end

def stub_get(path, endpoint = Yam.endpoint.to_s)
  stub_request(:get, endpoint + path)
end

def a_post(path, endpoint = Yam.endpoint.to_s)
  a_request(:post, endpoint + path)
end

def a_get(path, endpoint = Yam.endpoint.to_s)
  a_request(:get, endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, '/', file))
end
