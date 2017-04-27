require 'spec_helper'

describe 'TODO Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'todo.json'
    @fixtures_collection = 'todos.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'
    
    establish_connection
  end

  it 'returns a list of TODOs' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/todolists/#{@parent_id}/todos", @fixtures_collection)

    todos = Basecamp3::Todo.all(@bucket_id, @parent_id)
    expected_todos = json_to_model(@fixtures_collection, Basecamp3::Todo)

    expect(todos.count).to be(expected_todos.count)
    expect(todos).to all be_instance_of(Basecamp3::Todo)
    expect(todos.map{ |t| t.id }).to match_array(expected_todos.map{ |t| t.id })
  end

  it 'returns a specific TODO' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/todos/#{@id}", @fixtures_object)

    todo = Basecamp3::Todo.find(@bucket_id, @id)
    expected_todo = json_to_model(@fixtures_object, Basecamp3::Todo)

    expect(todo).to be_instance_of Basecamp3::Todo
    expect(todo.id).to eq(expected_todo.id)
  end

  it 'creates a TODO' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/todolists/#{@parent_id}/todos", @fixtures_object)

    todo = Basecamp3::Todo.create(@bucket_id, @parent_id, { content: 'test' })

    expect(todo).to be_instance_of(Basecamp3::Todo)
  end

  it 'should raise StandardError for missing required fields when creates a TODO' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/todolists/#{@parent_id}/todos", @fixtures_object)

    expect{ Basecamp3::Todo.create(@bucket_id, @parent_id, { }) }.to raise_error(StandardError)
  end

  it 'updates a TODO' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/todos/#{@id}", @fixtures_object)

    todo = Basecamp3::Todo.update(@bucket_id, @id, { content: 'test' })

    expect(todo).to be_instance_of(Basecamp3::Todo)
  end

  it 'should raise StandardError for missing required fields when updates a TODO' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/todos/#{@id}", @fixtures_object)

    expect{ Basecamp3::Todo.update(@bucket_id, @id, { }) }.to raise_error(StandardError)
  end

  it 'deletes a TODO' do
    stub_http_request(:put, "/buckets/#{@bucket_id}/recordings/#{@id}/status/trashed", nil, { status: 204 })

    response = Basecamp3::Todo.delete(@bucket_id, @id)

    expect(response).to be true
  end

  it 'completes a TODO' do
    stub_http_request(:post, "/buckets/#{@bucket_id}/todos/#{@id}/completion", nil, { status: 204 })

    response = Basecamp3::Todo.complete(@bucket_id, @id)

    expect(response).to be(true)
  end

  it 'incompletes a TODO' do
    stub_http_request(:delete, "/buckets/#{@bucket_id}/todos/#{@id}/completion", nil, { status: 204 })

    response = Basecamp3::Todo.incomplete(@bucket_id, @id)

    expect(response).to be(true)
  end

  it 'is creatorable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/todos/#{@id}", @fixtures_object)

    todo = Basecamp3::Todo.find(@bucket_id, @id)
    expect(todo.creator).to be_instance_of(Basecamp3::Person)
  end

  it 'is bucketable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/todos/#{@id}", @fixtures_object)

    todo = Basecamp3::Todo.find(@bucket_id, @id)
    expect(todo.bucket).to be_instance_of(Basecamp3::Project)
  end

  it 'is parentable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/todos/#{@id}", @fixtures_object)

    todo = Basecamp3::Todo.find(@bucket_id, @id)
    expect(todo.parent).to be_instance_of(Basecamp3::TodoList)
  end
end