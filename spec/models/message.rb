require 'spec_helper'

describe 'Message Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'message.json'
    @fixtures_collection = 'messages.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a list of messages' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/message_boards/#{@parent_id}/messages", @fixtures_collection)

    messages = Basecamp3::Message.all(@bucket_id, @parent_id)
    expected_messages = json_to_model(@fixtures_collection, Basecamp3::Message)

    expect(messages.count).to be(expected_messages.count)
    expect(messages).to all be_instance_of(Basecamp3::Message)
    expect(messages.map{ |t| t.id }).to match_array(expected_messages.map{ |t| t.id })
  end

  it 'returns a specific message' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/messages/#{@id}", @fixtures_object)

    message = Basecamp3::Message.find(@bucket_id, @id)
    expected_message = json_to_model(@fixtures_object, Basecamp3::Message)

    expect(message).to be_instance_of Basecamp3::Message
    expect(message.id).to eq(expected_message.id)
  end

  it 'creates a message' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/message_boards/#{@parent_id}/messages", @fixtures_object)

    message = Basecamp3::Message.create(@bucket_id, @parent_id, { subject: 'test' })

    expect(message).to be_instance_of(Basecamp3::Message)
  end

  it 'should raise StandardError for missing required fields when creates a message' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/message_boards/#{@parent_id}/messages", @fixtures_object)

    expect{ Basecamp3::Message.create(@bucket_id, @parent_id, { }) }.to raise_error(StandardError)
  end

  it 'updates a message' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/messages/#{@id}", @fixtures_object)

    message = Basecamp3::Message.update(@bucket_id, @id, { subject: 'test' })

    expect(message).to be_instance_of(Basecamp3::Message)
  end

  it 'should raise StandardError for missing required fields when updates a message' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/messages/#{@id}", @fixtures_object)

    expect{ Basecamp3::Message.update(@bucket_id, @id, { }) }.to raise_error(StandardError)
  end

  it 'deletes a message' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/recordings/#{@id}/status/trashed", nil, { status: 204 })

    response = Basecamp3::Message.delete(@bucket_id, @id)

    expect(response).to be true
  end
end