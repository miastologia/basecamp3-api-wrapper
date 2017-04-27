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

  describe 'Class' do
    it 'returns a specific questionnaire' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/questionnaires/#{@id}", @fixtures_object)

      questionnaire = Basecamp3::Questionnaire.find(@bucket_id, @id)
      expected_questionnaire = json_to_model(@fixtures_object, Basecamp3::Questionnaire)

      expect(questionnaire).to be_instance_of Basecamp3::Questionnaire
      expect(questionnaire.id).to eq(expected_questionnaire.id)
    end
  end

  describe 'Object' do
    it 'returns a list of questions' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/questionnaires/#{@id}", @fixtures_object)

      questionnaire = Basecamp3::Questionnaire.find(@bucket_id, @id)


      stub_http_request(
        :get,
        "/buckets/#{questionnaire.bucket.id}/questionnaires/#{questionnaire.id}/questions",
        'questions.json'
      )

      expect(questionnaire.questions).to all be_instance_of(Basecamp3::Question)
    end

    it 'is creatorable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/questionnaires/#{@id}", @fixtures_object)

      questionnaire = Basecamp3::Questionnaire.find(@bucket_id, @id)
      expect(questionnaire.creator).to be_instance_of(Basecamp3::Person)
    end

    it 'is bucketable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/questionnaires/#{@id}", @fixtures_object)

      questionnaire = Basecamp3::Questionnaire.find(@bucket_id, @id)
      expect(questionnaire.bucket).to be_instance_of(Basecamp3::Project)
    end
  end
end