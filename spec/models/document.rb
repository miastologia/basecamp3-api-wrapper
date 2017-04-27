require 'spec_helper'

describe 'Document Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'document.json'
    @fixtures_collection = 'documents.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a list of documents' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/vaults/#{@parent_id}/documents", @fixtures_collection)

    documents = Basecamp3::Document.all(@bucket_id, @parent_id)
    expected_documents = json_to_model(@fixtures_collection, Basecamp3::Document)

    expect(documents.count).to be(expected_documents.count)
    expect(documents).to all be_instance_of(Basecamp3::Document)
    expect(documents.map{ |t| t.id }).to match_array(expected_documents.map{ |t| t.id })
  end

  it 'returns a specific document' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/documents/#{@id}", @fixtures_object)

    document = Basecamp3::Document.find(@bucket_id, @id)
    expected_document = json_to_model(@fixtures_object, Basecamp3::Document)

    expect(document).to be_instance_of Basecamp3::Document
    expect(document.id).to eq(expected_document.id)
  end

  it 'creates a document' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/vaults/#{@parent_id}/documents", @fixtures_object)

    document = Basecamp3::Document.create(@bucket_id, @parent_id, { title: 'test', content: 'test' })

    expect(document).to be_instance_of(Basecamp3::Document)
  end

  it 'should raise StandardError for missing required fields when creates a document' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/vaults/#{@parent_id}/documents", @fixtures_object)

    expect{ Basecamp3::Document.create(@bucket_id, @parent_id, { }) }.to raise_error(StandardError)
  end

  it 'updates a document' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/documents/#{@id}", @fixtures_object)

    document = Basecamp3::Document.update(@bucket_id, @id, { title: 'test', content: 'test' })

    expect(document).to be_instance_of(Basecamp3::Document)
  end

  it 'should raise StandardError for missing required fields when updates a document' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/documents/#{@id}", @fixtures_object)

    expect{ Basecamp3::Document.update(@bucket_id, @id, { }) }.to raise_error(StandardError)
  end

  it 'deletes a document' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/recordings/#{@id}/status/trashed", nil, { status: 204 })

    response = Basecamp3::Document.delete(@bucket_id, @id)

    expect(response).to be true
  end

  it 'is creatorable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/documents/#{@id}", @fixtures_object)

    document = Basecamp3::Document.find(@bucket_id, @id)
    expect(document.creator).to be_instance_of(Basecamp3::Person)
  end

  it 'is bucketable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/documents/#{@id}", @fixtures_object)

    document = Basecamp3::Document.find(@bucket_id, @id)
    expect(document.bucket).to be_instance_of(Basecamp3::Project)
  end

  it 'is parentable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/documents/#{@id}", @fixtures_object)

    document = Basecamp3::Document.find(@bucket_id, @id)
    expect(document.parent).to be_instance_of(Basecamp3::Vault)
  end
end