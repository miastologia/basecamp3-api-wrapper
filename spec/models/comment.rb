require 'spec_helper'

describe 'Comment Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'comment.json'
    @fixtures_collection = 'comments.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a list of comments' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/recordings/#{@parent_id}/comments", @fixtures_collection)

    comments = Basecamp3::Comment.all(@bucket_id, @parent_id)
    expected_comments = json_to_model(@fixtures_collection, Basecamp3::Comment)

    expect(comments.count).to be(expected_comments.count)
    expect(comments).to all be_instance_of(Basecamp3::Comment)
    expect(comments.map{ |c| c.id }).to match_array(expected_comments.map{ |c| c.id })
  end

  it 'returns a specific comment' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/comments/#{@id}", @fixtures_object)

    comment = Basecamp3::Comment.find(@bucket_id, @id)
    expected_comment = json_to_model(@fixtures_object, Basecamp3::Comment)

    expect(comment).to be_instance_of Basecamp3::Comment
    expect(comment.id).to eq(expected_comment.id)
  end

  it 'creates a comment' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/recordings/#{@parent_id}/comments", @fixtures_object)

    comment = Basecamp3::Comment.create(@bucket_id, @parent_id, { content: 'test' })

    expect(comment).to be_instance_of(Basecamp3::Comment)
  end

  it 'should raise StandardError for missing required fields when creates a comment' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/recordings/#{@parent_id}/comments", @fixtures_object)

    expect{ Basecamp3::Comment.create(@bucket_id, @parent_id, { }) }.to raise_error(StandardError)
  end

  it 'updates a comment' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/comments/#{@id}", @fixtures_object)

    comment = Basecamp3::Comment.update(@bucket_id, @id, { content: 'test' })

    expect(comment).to be_instance_of(Basecamp3::Comment)
  end

  it 'should raise StandardError for missing required fields when updates a comment' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/comments/#{@id}", @fixtures_object)

    expect{ Basecamp3::Comment.update(@bucket_id, @id, { }) }.to raise_error(StandardError)
  end

  it 'deletes a comment' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/recordings/#{@id}/status/trashed", nil, { status: 204 })

    response = Basecamp3::Comment.delete(@bucket_id, @id)

    expect(response).to be true
  end

  it 'is creatorable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/comments/#{@id}", @fixtures_object)

    comment = Basecamp3::Comment.find(@bucket_id, @id)
    expect(comment.creator).to be_instance_of(Basecamp3::Person)
  end

  it 'is bucketable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/comments/#{@id}", @fixtures_object)

    comment = Basecamp3::Comment.find(@bucket_id, @id)
    expect(comment.bucket).to be_instance_of(Basecamp3::Project)
  end

  it 'is parentable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/comments/#{@id}", @fixtures_object)

    comment = Basecamp3::Comment.find(@bucket_id, @id)
    expect(comment.parent).to be_instance_of(Basecamp3::Message)
  end
end