require 'spec_helper'

describe Yam::Client, '#get' do
  it 'makes requests' do
    stub_get('/custom/get')
    subject.get('/custom/get')
    expect(a_get('/custom/get')).to have_been_made
  end
end

describe Yam::Client, '#post' do
  it 'makes requests' do
    stub_post('/custom/post')
    subject.post('/custom/post')
    expect(a_post('/custom/post')).to have_been_made
  end

  it 'makes authorized requests' do
    access_token = '123'
    Yam.oauth_token = access_token
    stub_post("/custom/post?access_token=#{access_token}")
    subject.post('/custom/post')
    expect(a_post("/custom/post?access_token=#{access_token}")).to have_been_made
  end
end
