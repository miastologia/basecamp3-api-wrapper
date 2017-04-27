require 'spec_helper'

describe 'Questionnaire Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'questionnaire.json'

    @bucket_id = '12345'
    @parent_id = '12345'
    @id = '12345'

    establish_connection
  end

  it 'returns a specific questionnaire' do
    stub_http_request(:get, "/buckets/#{@bucket_id}/questionnaires/#{@id}", @fixtures_object)

    questionnaire = Basecamp3::Questionnaire.find(@bucket_id, @id)
    expected_questionnaire = json_to_model(@fixtures_object, Basecamp3::Questionnaire)

    expect(questionnaire).to be_instance_of Basecamp3::Questionnaire
    expect(questionnaire.id).to eq(expected_questionnaire.id)
  end
end