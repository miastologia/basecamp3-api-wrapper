# A model for Basecamp's Message
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/messages.md#messages For more information, see the official Basecamp3 API documentation for Messages}
class Basecamp3::Message < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable
  include Basecamp3::Concerns::Recordingable
  include Basecamp3::Concerns::Commentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :subject,
                :content

  REQUIRED_FIELDS = %w(subject)

  # Returns a paginated list of active messages.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the message board
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::Message>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/message_boards/#{parent_id}/messages", params, Basecamp3::Message)
  end

  # Returns the message.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the message
  #
  # @return [Basecamp3::Message]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/messages/#{id}", {}, Basecamp3::Message)
  end

  # Creates a message.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the message board
  # @param [Hash] data the data to create a message with
  # @option params [Integer] :subject (required) the title of the message
  # @option params [String] :status (required) set to active to publish immediately
  # @option params [String] :content (optional) the body of the message
  # @option params [Integer] :category_id (optional) to set a type for the message
  #
  # @return [Basecamp3::Message]
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/message_boards/#{parent_id}/messages", data, Basecamp3::Message)
  end

  # Updates the message.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the message
  # @param [Hash] data the data to update the message with
  # @option params [Integer] :subject (required) the title of the message
  # @option params [String] :status (required) set to active to publish immediately
  # @option params [String] :content (optional) the body of the message
  # @option params [Integer] :category_id (optional) to set a type for the message
  #
  # @return [Basecamp3::Message]
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/messages/#{id}", data, Basecamp3::Message)
  end
end