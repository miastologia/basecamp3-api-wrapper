require 'spec_helper'

describe 'TODO List Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'todo_list.json'
    @fixtures_collection = 'todo_lists.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a list of TODO lists' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/todosets/#{@parent_id}/todolists", @fixtures_collection)

    todo_lists = Basecamp3::TodoList.all(@bucket_id, @parent_id)
    expected_todo_lists = json_to_model(@fixtures_collection, Basecamp3::TodoList)

    expect(todo_lists.count).to be(expected_todo_lists.count)
    expect(todo_lists).to all be_instance_of(Basecamp3::TodoList)
    expect(todo_lists.map{ |t| t.id }).to match_array(expected_todo_lists.map{ |t| t.id })
  end

  it 'returns a specific TODO list' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/todolists/#{@id}", @fixtures_object)

    todo_list = Basecamp3::TodoList.find(@bucket_id, @id)
    expected_todo_list = json_to_model(@fixtures_object, Basecamp3::TodoList)

    expect(todo_list).to be_instance_of Basecamp3::TodoList
    expect(todo_list.id).to eq(expected_todo_list.id)
  end

  it 'creates a TODO list' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/todosets/#{@parent_id}/todolists", @fixtures_object)

    todo_list = Basecamp3::TodoList.create(@bucket_id, @parent_id, { name: 'test' })

    expect(todo_list).to be_instance_of(Basecamp3::TodoList)
  end

  it 'should raise StandardError for missing required fields when creates a TODO list' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/todosets/#{@parent_id}/todolists", @fixtures_object)

    expect{ Basecamp3::TodoList.create(@bucket_id, @parent_id, { }) }.to raise_error(StandardError)
  end

  it 'updates a TODO list' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/todolists/#{@id}", @fixtures_object)

    todo_list = Basecamp3::TodoList.update(@bucket_id, @id, { name: 'test' })

    expect(todo_list).to be_instance_of(Basecamp3::TodoList)
  end

  it 'should raise StandardError for missing required fields when updates a TODO list' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/todos/#{@id}", @fixtures_object)

    expect{ Basecamp3::TodoList.update(@bucket_id, @id, { }) }.to raise_error(StandardError)
  end

  it 'deletes a TODO list' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/recordings/#{@id}/status/trashed", nil, { status: 204 })

    response = Basecamp3::TodoList.delete(@bucket_id, @id)

    expect(response).to be true
  end
end