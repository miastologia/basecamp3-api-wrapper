require 'spec_helper'

describe 'Request' do
  include RequestHelpers

  before(:each) do
    @request = Basecamp3::Request.new('12345', 'https://3.basecampapi.com/12345')

    establish_connection
  end

  it 'calls a request method' do
    stub_http_request(:get, '/method', nil, { status: 204 })

    response = @request.request(:get, '/method')

    expect(response).to be(true)
  end

  it 'calls the http get method' do
    stub_http_request(:get, '/method', nil, { status: 204 })

    response = @request.get('/method')

    expect(response).to be(true)
  end

  it 'calls the http post method' do
    stub_http_request(:post, '/method', nil, { status: 204, body: { content: 'test' } })

    response = @request.post('/method', { content: 'test' })

    expect(response).to be(true)
  end

  it 'calls the http put method' do
    stub_http_request(:put, '/method', nil, { status: 204, body: { content: 'test' } })

    response = @request.put('/method', { content: 'test' })

    expect(response).to be(true)
  end

  it 'calls the http delete method' do
    stub_http_request(:delete, '/method', nil, { status: 204 })

    response = @request.delete('/method')

    expect(response).to be(true)
  end
  
  it 'should raise StandardError for unsupported http method' do
    expect{ @request.request(:unsupported_method, '/') }.to raise_error(StandardError)
  end
end