require 'spec_helper'

describe 'TODO Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'campfire_line.json'
    @fixtures_collection = 'campfire_lines.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a list of campfire lines' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/chats/#{@parent_id}/lines", @fixtures_collection)

    campfire_lines = Basecamp3::CampfireLine.all(@bucket_id, @parent_id)
    expected_campfire_lines = json_to_model(@fixtures_collection, Basecamp3::CampfireLine)

    expect(campfire_lines.count).to be(expected_campfire_lines.count)
    expect(campfire_lines).to all be_instance_of(Basecamp3::CampfireLine)
    expect(campfire_lines.map{ |t| t.id }).to match_array(expected_campfire_lines.map{ |t| t.id })
  end

  it 'returns a specific campfire line' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/chats/#{@parent_id}/lines/#{@id}", @fixtures_object)

    campfire_line = Basecamp3::CampfireLine.find(@bucket_id, @parent_id, @id)
    expected_campfire_line = json_to_model(@fixtures_object, Basecamp3::CampfireLine)

    expect(campfire_line).to be_instance_of Basecamp3::CampfireLine
    expect(campfire_line.id).to eq(expected_campfire_line.id)
  end

  it 'creates a campfire line' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/chats/#{@parent_id}/lines", @fixtures_object)

    campfire_line = Basecamp3::CampfireLine.create(@bucket_id, @parent_id, { content: 'test' })

    expect(campfire_line).to be_instance_of(Basecamp3::CampfireLine)
  end

  it 'should raise StandardError for missing required fields when creates a campfire line' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/chats/#{@parent_id}/lines", @fixtures_object)

    expect{ Basecamp3::CampfireLine.create(@bucket_id, @parent_id, { }) }.to raise_error(StandardError)
  end
end