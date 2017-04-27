require 'spec_helper'

describe 'Question Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'question.json'
    @fixtures_collection = 'questions.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a list of questions' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/questionnaires/#{@parent_id}/questions", @fixtures_collection)

    questions = Basecamp3::Question.all(@bucket_id, @parent_id)
    expected_questions = json_to_model(@fixtures_collection, Basecamp3::Question)

    expect(questions.count).to be(expected_questions.count)
    expect(questions).to all be_instance_of(Basecamp3::Question)
    expect(questions.map{ |t| t.id }).to match_array(expected_questions.map{ |t| t.id })
  end

  it 'returns a specific question' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/questions/#{@id}", @fixtures_object)

    todo = Basecamp3::Question.find(@bucket_id, @id)
    expected_todo = json_to_model(@fixtures_object, Basecamp3::Question)

    expect(todo).to be_instance_of Basecamp3::Question
    expect(todo.id).to eq(expected_todo.id)
  end
end