# A model for Basecamp's Message Board
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/message_types.md#get-message-types For more information, see the official Basecamp3 API documentation for Message types}
class Basecamp3::MessageType < Basecamp3::Model
  attr_accessor :id,
                :created_at,
                :updated_at,
                :name,
                :icon

  REQUIRED_FIELDS = %w(name icon)

  # Returns a list of all the message types.
  #
  # @param [Integer] bucket_id the id of the bucket
  #
  # @return [Array<Basecamp3::MessageType>]
  def self.all(bucket_id)
    Basecamp3.request.get("/buckets/#{bucket_id}/categories", {}, Basecamp3::MessageType)
  end

  # Returns the message type.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the message type
  #
  # @return [Basecamp3::MessageType]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/categories/#{id}", {}, Basecamp3::MessageType)
  end

  # Creates a message type.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Hash] data the data to create a message type with
  # @option params [String] :name (required) the name of the message type
  # @option params [String] :icon (required) the icon of the message type
  #
  # @return [Basecamp3::MessageType]
  def self.create(bucket_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/categories", data, Basecamp3::MessageType)
  end

  # Updates a message type.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the message type
  # @param [Hash] data the data to update the message type with
  # @option params [String] :name (required) the name of the message type
  # @option params [String] :icon (required) the icon of the message type
  #
  # @return [Basecamp3::MessageType]
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/categories/#{id}", data, Basecamp3::MessageType)
  end

  # Deletes the message type.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the message type
  #
  # @return [Boolean]
  def self.delete(bucket_id, id)
    Basecamp3.request.delete("/buckets/#{bucket_id}/categories/#{id}")
  end
end