require 'spec_helper'

describe 'TODO Campfire' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'campfire.json'
    @fixtures_collection = 'campfires.json'

    @bucket_id = '12345'
    @id = '12345'

    establish_connection
  end

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

    expect(campfire).to be_instance_of Basecamp3::Campfire
    expect(campfire.id).to eq(expected_campfire.id)
  end
end