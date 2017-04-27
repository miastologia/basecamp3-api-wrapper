require 'spec_helper'

describe 'Inbox Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'inbox.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  describe 'Class' do
    it 'returns a specific inbox' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/inboxes/#{@id}", @fixtures_object)

      inbox = Basecamp3::Inbox.find(@bucket_id, @id)
      expected_inbox = json_to_model(@fixtures_object, Basecamp3::Inbox)

      expect(inbox).to be_instance_of Basecamp3::Inbox
      expect(inbox.id).to eq(expected_inbox.id)
    end
  end

  describe 'Object' do
    it 'returns a list of forwards' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/inboxes/#{@id}", @fixtures_object)

      inbox = Basecamp3::Inbox.find(@bucket_id, @id)

      stub_http_request(:get, "/buckets/#{inbox.bucket.id}/inboxes/#{inbox.id}/forwards", 'forwards.json')

      expect(inbox.forwards).to all be_instance_of(Basecamp3::Forward)
    end

    it 'is creatorable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/inboxes/#{@id}", @fixtures_object)

      inbox = Basecamp3::Inbox.find(@bucket_id, @id)
      expect(inbox.creator).to be_instance_of(Basecamp3::Person)
    end

    it 'is bucketable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/inboxes/#{@id}", @fixtures_object)

      inbox = Basecamp3::Inbox.find(@bucket_id, @id)
      expect(inbox.bucket).to be_instance_of(Basecamp3::Project)
    end
  end
end