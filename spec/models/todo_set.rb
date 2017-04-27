require 'spec_helper'

describe 'TODO Set Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'todo_list.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  describe 'Class' do
    it 'returns a specific TODO list' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/todosets/#{@id}", @fixtures_object)

      todo_set = Basecamp3::TodoSet.find(@bucket_id, @id)
      expected_todo_set = json_to_model(@fixtures_object, Basecamp3::TodoSet)

      expect(todo_set).to be_instance_of Basecamp3::TodoSet
      expect(todo_set.id).to eq(expected_todo_set.id)
    end
  end

  describe 'Object' do
    it 'returns a list of todo lists' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/todosets/#{@id}", @fixtures_object)

      todo_set = Basecamp3::TodoSet.find(@bucket_id, @id)

      stub_http_request(:get, "/buckets/#{todo_set.bucket.id}/todosets/#{todo_set.id}/todolists", 'todo_lists.json')

      expect(todo_set.todo_lists).to all be_instance_of(Basecamp3::TodoList)
    end

    it 'is creatorable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/todosets/#{@id}", @fixtures_object)

      todo_set = Basecamp3::TodoSet.find(@bucket_id, @id)
      expect(todo_set.creator).to be_instance_of(Basecamp3::Person)
    end

    it 'is bucketable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/todosets/#{@id}", @fixtures_object)

      todo_set = Basecamp3::TodoSet.find(@bucket_id, @id)
      expect(todo_set.bucket).to be_instance_of(Basecamp3::Project)
    end
  end
end