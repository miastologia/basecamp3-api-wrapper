require 'spec_helper'

describe 'MessageType Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'message_type.json'
    @fixtures_collection = 'message_types.json'

    @bucket_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a list of message types' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/categories", @fixtures_collection)

    message_types = Basecamp3::MessageType.all(@bucket_id)
    expected_message_types = json_to_model(@fixtures_collection, Basecamp3::MessageType)

    expect(message_types.count).to be(expected_message_types.count)
    expect(message_types).to all be_instance_of(Basecamp3::MessageType)
    expect(message_types.map{ |t| t.id }).to match_array(expected_message_types.map{ |t| t.id })
  end

  it 'returns a specific message type' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/categories/#{@id}", @fixtures_object)

    message_type = Basecamp3::MessageType.find(@bucket_id, @id)
    expected_message_type = json_to_model(@fixtures_object, Basecamp3::MessageType)

    expect(message_type).to be_instance_of Basecamp3::MessageType
    expect(message_type.id).to eq(expected_message_type.id)
  end

  it 'creates a message type' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/categories", @fixtures_object)

    message_type = Basecamp3::MessageType.create(@bucket_id, { name: 'test', icon: 'message' })

    expect(message_type).to be_instance_of(Basecamp3::MessageType)
  end

  it 'should raise StandardError for missing required fields when creates a message type' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/categories", @fixtures_object)

    expect{ Basecamp3::MessageType.create(@bucket_id, { name: 'test' }) }.to raise_error(StandardError)
  end

  it 'updates a message type' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/categories/#{@id}", @fixtures_object)

    message_type = Basecamp3::MessageType.update(@bucket_id, @id, { name: 'test', icon: 'message' })

    expect(message_type).to be_instance_of(Basecamp3::MessageType)
  end

  it 'should raise StandardError for missing required fields when updates a message type' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/categories/#{@id}", @fixtures_object)

    expect{ Basecamp3::MessageType.update(@bucket_id, @id, { name: 'test' }) }.to raise_error(StandardError)
  end

  it 'deletes a message type' do
    stub_http_request(:delete, "/buckets/#{@bucket_id}/categories/#{@id}", nil, { status: 204 })

    response = Basecamp3::MessageType.delete(@bucket_id, @id)

    expect(response).to be true
  end
end