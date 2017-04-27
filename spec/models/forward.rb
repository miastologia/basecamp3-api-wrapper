require 'spec_helper'

describe 'Forward Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'forward.json'
    @fixtures_collection = 'forwards.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a list of forwards' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/inboxes/#{@parent_id}/forwards", @fixtures_collection)

    forwards = Basecamp3::Forward.all(@bucket_id, @parent_id)
    expected_forwards = json_to_model(@fixtures_collection, Basecamp3::Forward)

    expect(forwards.count).to be(expected_forwards.count)
    expect(forwards).to all be_instance_of(Basecamp3::Forward)
    expect(forwards.map{ |t| t.id }).to match_array(expected_forwards.map{ |t| t.id })
  end

  it 'returns a specific forward' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/inbox_forwards/#{@id}", @fixtures_object)

    forward = Basecamp3::Forward.find(@bucket_id, @id)
    expected_forward = json_to_model(@fixtures_object, Basecamp3::Forward)

    expect(forward).to be_instance_of Basecamp3::Forward
    expect(forward.id).to eq(expected_forward.id)
  end

  it 'deletes a forward' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/recordings/#{@id}/status/trashed", nil, { status: 204 })

    response = Basecamp3::Forward.delete(@bucket_id, @id)

    expect(response).to be true
  end

  it 'is creatorable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/inbox_forwards/#{@id}", @fixtures_object)

    forward = Basecamp3::Forward.find(@bucket_id, @id)
    expect(forward.creator).to be_instance_of(Basecamp3::Person)
  end

  it 'is bucketable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/inbox_forwards/#{@id}", @fixtures_object)

    forward = Basecamp3::Forward.find(@bucket_id, @id)
    expect(forward.bucket).to be_instance_of(Basecamp3::Project)
  end

  it 'is parentable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/inbox_forwards/#{@id}", @fixtures_object)

    forward = Basecamp3::Forward.find(@bucket_id, @id)
    expect(forward.parent).to be_instance_of(Basecamp3::Inbox)
  end
end