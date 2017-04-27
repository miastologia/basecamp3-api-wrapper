require 'spec_helper'

describe 'Campfire Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'campfire.json'
    @fixtures_collection = 'campfires.json'

    @bucket_id = '12345'
    @id = '12345'

    establish_connection
  end

  describe 'Class' do
    it 'returns a list of campfires' do
      stub_http_request(:get, "/chats", @fixtures_collection)

      campfires = Basecamp3::Campfire.all
      expected_campfires = json_to_model(@fixtures_collection, Basecamp3::Campfire)

      expect(campfires.count).to be(expected_campfires.count)
      expect(campfires).to all be_instance_of(Basecamp3::Campfire)
      expect(campfires.map{ |t| t.id }).to match_array(expected_campfires.map{ |t| t.id })
    end

    it 'returns a specific campfire' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/chats/#{@id}", @fixtures_object)

      campfire = Basecamp3::Campfire.find(@bucket_id, @id)
      expected_campfire = json_to_model(@fixtures_object, Basecamp3::Campfire)

      expect(campfire).to be_instance_of(Basecamp3::Campfire)
      expect(campfire.id).to eq(expected_campfire.id)
    end
  end

  describe 'Object' do
    it 'returns a list of campfire lines' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/chats/#{@id}", @fixtures_object)

      campfire = Basecamp3::Campfire.find(@bucket_id, @id)

      stub_http_request(:get, "/buckets/#{campfire.bucket.id}/chats/#{campfire.id}/lines", @fixtures_collection)


      expect(campfire.lines).to all be_instance_of(Basecamp3::CampfireLine)
    end

    it 'is creatorable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/chats/#{@id}", @fixtures_object)

      campfire = Basecamp3::Campfire.find(@bucket_id, @id)
      expect(campfire.creator).to be_instance_of(Basecamp3::Person)
    end

    it 'is bucketable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/chats/#{@id}", @fixtures_object)

      campfire = Basecamp3::Campfire.find(@bucket_id, @id)
      expect(campfire.bucket).to be_instance_of(Basecamp3::Project)
    end
  end
end