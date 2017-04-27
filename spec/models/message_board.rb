require 'spec_helper'

describe 'MessageBoard Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'message_board.json'

    @bucket_id = '12345'
    @id = '12345'

    establish_connection
  end

  describe 'Class' do
    it 'returns a specific message board' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/message_boards/#{@id}", @fixtures_object)

      message_board = Basecamp3::MessageBoard.find(@bucket_id, @id)
      expected_message_board = json_to_model(@fixtures_object, Basecamp3::MessageBoard)

      expect(message_board).to be_instance_of(Basecamp3::MessageBoard)
      expect(message_board.id).to eq(expected_message_board.id)
    end
  end

  describe 'Object' do
    it 'returns a list of messages' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/message_boards/#{@id}", @fixtures_object)

      message_board = Basecamp3::MessageBoard.find(@bucket_id, @id)

      stub_http_request(
        :get,
        "/buckets/#{message_board.bucket.id}/message_boards/#{message_board.id}/messages",
        'messages.json'
      )

      expect(message_board.messages).to all be_instance_of(Basecamp3::Message)
    end

    it 'is creatorable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/message_boards/#{@id}", @fixtures_object)

      message_board = Basecamp3::MessageBoard.find(@bucket_id, @id)
      expect(message_board.creator).to be_instance_of(Basecamp3::Person)
    end

    it 'is bucketable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/message_boards/#{@id}", @fixtures_object)

      message_board = Basecamp3::MessageBoard.find(@bucket_id, @id)
      expect(message_board.bucket).to be_instance_of(Basecamp3::Project)
    end
  end
end