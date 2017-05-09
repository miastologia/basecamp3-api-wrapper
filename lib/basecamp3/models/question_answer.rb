# A model for Basecamp's Question Answer
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/question_answers.md#question-answers For more information, see the official Basecamp3 API documentation for Question Answers}
class Basecamp3::QuestionAnswer < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :content,
                :group_on

  # Returns a paginated list of answers.
  #
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::QuestionAnswer>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/questions/#{parent_id}/answers", params, Basecamp3::QuestionAnswer)
  end

  # Returns the answer.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the question
  #
  # @return [Basecamp3::QuestionAnswer]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/question_answers/#{id}", {}, Basecamp3::QuestionAnswer)
  end
end