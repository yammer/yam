# encoding: utf-8

require 'spec_helper'

describe Yam do

  after do
    subject.set_defaults
  end

  it "should respond to 'new' message" do
    subject.should respond_to :new
  end

  it "should receive 'new' and initialize subject::Client instance" do
    subject.new.should be_a Yam::Client
  end

  it "should respond to 'configure' message" do
    subject.should respond_to :configure
  end

  describe "setting configuration options" do
    it "should return the default end point" do
      subject.endpoint.should == Yam::Configuration::DEFAULT_ENDPOINT
    end

    it "should allow to set endpoint" do
      subject.endpoint = 'http://linkedin.com'
      subject.endpoint.should == 'http://linkedin.com'
    end

    it "should have not set oauth token" do
      subject.oauth_token.should be_nil
    end

    it "should allow to set oauth token" do
      subject.oauth_token = 'OT'
      subject.oauth_token.should == 'OT'
    end

    it "should allow to set current api client" do
      subject.should respond_to :api_client=
      subject.should respond_to :api_client
    end
  end

  describe ".configure" do
    Yam::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Yam.configure do |config|
          config.send("#{key}=", key)
          Yam.send(key).should == key
        end
      end
    end
  end

end # Yam
