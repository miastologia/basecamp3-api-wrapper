# A model for Basecamp's Campfire
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/campfires.md#campfires For more information, see the official Basecamp3 API documentation for Campfires}
class Basecamp3::Campfire < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :topic

  REQUIRED_FIELDS = %w(topic)

  # Returns a list of related lines.
  #
  # @return [Array<Basecamp3::CampfireLine>]
  def lines
    @mapped_lines ||= Basecamp3::CampfireLine.all(bucket.id, id)
  end

  # Returns a paginated list of all active campfires visible to the current user.
  #
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::Campfire>]
  def self.all(params = {})
    Basecamp3.request.get("/chats", params, Basecamp3::Campfire)
  end

  # Returns the campfire.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the campfire
  #
  # @return [Basecamp3::Campfire]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/chats/#{id}", {}, Basecamp3::Campfire)
  end
end