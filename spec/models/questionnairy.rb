require 'spec_helper'

describe 'Questionnairy Model' do
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

  it 'returns a specific questionnairy' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/questionnaires/#{@id}", @fixtures_object)

    questionnairy = Basecamp3::Questionnairy.find(@bucket_id, @id)
    expected_questionnairy = json_to_model(@fixtures_object, Basecamp3::Questionnairy)

    expect(questionnairy).to be_instance_of Basecamp3::Questionnairy
    expect(questionnairy.id).to eq(expected_questionnairy.id)
  end
end