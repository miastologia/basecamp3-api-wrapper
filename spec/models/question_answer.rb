require 'spec_helper'

describe 'QuestionAnswerAnswer Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'question_answer.json'
    @fixtures_collection = 'question_answers.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a list of answers' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/questions/#{@parent_id}/answers", @fixtures_collection)

    answers = Basecamp3::QuestionAnswer.all(@bucket_id, @parent_id)
    expected_answers = json_to_model(@fixtures_collection, Basecamp3::QuestionAnswer)

    expect(answers.count).to be(expected_answers.count)
    expect(answers).to all be_instance_of(Basecamp3::QuestionAnswer)
    expect(answers.map{ |t| t.id }).to match_array(expected_answers.map{ |t| t.id })
  end

  it 'returns a specific answer' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/question_answers/#{@id}", @fixtures_object)

    answer = Basecamp3::QuestionAnswer.find(@bucket_id, @id)
    expected_answer = json_to_model(@fixtures_object, Basecamp3::QuestionAnswer)

    expect(answer).to be_instance_of Basecamp3::QuestionAnswer
    expect(answer.id).to eq(expected_answer.id)
  end

  it 'is creatorable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/question_answers/#{@id}", @fixtures_object)

    answer = Basecamp3::QuestionAnswer.find(@bucket_id, @id)
    expect(answer.creator).to be_instance_of(Basecamp3::Person)
  end

  it 'is bucketable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/question_answers/#{@id}", @fixtures_object)

    answer = Basecamp3::QuestionAnswer.find(@bucket_id, @id)
    expect(answer.bucket).to be_instance_of(Basecamp3::Project)
  end

  it 'is parentable' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/question_answers/#{@id}", @fixtures_object)

    answer = Basecamp3::QuestionAnswer.find(@bucket_id, @id)
    expect(answer.parent).to be_instance_of(Basecamp3::Question)
  end
end