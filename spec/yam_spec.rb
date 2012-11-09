require 'spec_helper'
class TestClass
end
describe Yam do

  after do
    subject.set_defaults
  end

  it 'responds to \'new\' message' do
    subject.should respond_to :new
  end

  it 'receives \'new\' and initialize subject::Client instance' do
    subject.new.should be_a Yam::Client
  end

  it 'delegates to a Yam::Client instance' do
    Yam::Client.any_instance.stubs(:stubbed_method)

    Yam.stubbed_method

    Yam::Client.any_instance.should have_received(:stubbed_method)
  end

  it 'responds to \'configure\' message' do
    subject.should respond_to :configure
  end

  describe 'setting configuration options' do
    it 'returns the default adapter' do
      subject.adapter.should == Yam::Configuration::DEFAULT_ADAPTER
    end

    it 'allows setting the adapter' do
      subject.adapter = :typhoeus
      subject.adapter.should == :typhoeus
    end

    it 'returns the default end point' do
      subject.endpoint.should == Yam::Configuration::DEFAULT_ENDPOINT
    end

    it 'allows setting the endpoint' do
      subject.endpoint = 'http://www.example.com'
      subject.endpoint.should == 'http://www.example.com'
    end

    it 'returns the default user agent' do
      subject.user_agent.should == Yam::Configuration::DEFAULT_USER_AGENT
    end

    it 'allows setting the user agent' do
      subject.user_agent = 'New User Agent'
      subject.user_agent.should == 'New User Agent'
    end

    it 'does not set oauth token' do
      subject.oauth_token.should be_nil
    end

    it 'does not allow setting the oauth token' do
      subject.oauth_token = 'OT'
      subject.oauth_token.should == 'OT'
    end

    it 'allows setting the current api client' do
      subject.should respond_to :api_client=
      subject.should respond_to :api_client
    end
  end

  describe '.configure' do
    Yam::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Yam.configure do |config|
          config.send("#{key}=", key)
          Yam.send(key).should == key
        end
      end
    end
  end
end
