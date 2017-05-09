# A model for Basecamp's Comment
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/comments.md#comments For more information, see the official Basecamp3 API documentation for Comments}
class Basecamp3::Comment < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable
  include Basecamp3::Concerns::Recordingable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :content,
                :parent_id,
                :bucket_id

  REQUIRED_FIELDS = %w(content)

  # Returns a paginated list of active comments.
  #
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::Comment>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/recordings/#{parent_id}/comments", params, Basecamp3::Comment)
  end

  # Returns the comment.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the comment
  #
  # @return [Basecamp3::Comment]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/comments/#{id}", {}, Basecamp3::Comment)
  end

  # Creates a comment.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the parent
  # @param [Hash] data the data to create a comment with
  # @option params [String] :content (required) the body of the comment
  #
  # @return [Basecamp3::Comment]
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/recordings/#{parent_id}/comments", data, Basecamp3::Comment)
  end

  # Updates the comment.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the comment
  # @param [Hash] data the data to update the comment with
  # @option params [String] :content (required) the body of the comment
  #
  # @return [Basecamp3::Comment]
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/comments/#{id}", data, Basecamp3::Comment)
  end
end