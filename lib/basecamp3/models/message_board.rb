# A model for Basecamp's Message Board
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/message_boards.md#message-boards For more information, see the official Basecamp3 API documentation for Message boards}
class Basecamp3::MessageBoard < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :messages_count

  # Returns a list of related messages.
  #
  # @return [Array<Basecamp3::Message>]
  def messages
    @mapped_messages ||= Basecamp3::Message.all(bucket.id, id)
  end

  # Returns the message board.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the message board
  #
  # @return [Basecamp3::MessageBoard]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/message_boards/#{id}", {}, Basecamp3::MessageBoard)
  end
end