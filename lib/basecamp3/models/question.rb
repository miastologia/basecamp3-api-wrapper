# A model for Basecamp's Question
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/questions.md#questions For more information, see the official Basecamp3 API documentation for Questions}
class Basecamp3::Question < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :paused,
                :answers_count

  # Returns a list of related answers.
  #
  # @return [Array<Basecamp3::QuestionAnswer>]
  def answers
    @mapped_answers ||= Basecamp3::QuestionAnswer.all(bucket.id, id)
  end

  # Returns a paginated list of questions.
  #
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::Question>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/questionnaires/#{parent_id}/questions", params, Basecamp3::Question)
  end

  # Returns the question.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the question
  #
  # @return [Basecamp3::Question]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/questions/#{id}", {}, Basecamp3::Question)
  end
end