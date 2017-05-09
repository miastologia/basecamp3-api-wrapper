# A model for Basecamp's Questionnaire
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/questionnaires.md#questionnaires For more information, see the official Basecamp3 API documentation for Questionnaires}
class Basecamp3::Questionnaire < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :name,
                :questions_count

  # Returns a list of related questions.
  #
  # @return [Array<Basecamp3::Question>]
  def questions
    @mapped_questions ||= Basecamp3::Question.all(bucket.id, id)
  end

  # Returns the questionnaire.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the questionnaire
  #
  # @return [Basecamp3::Questionnaire]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/questionnaires/#{id}", {}, Basecamp3::Questionnaire)
  end
end