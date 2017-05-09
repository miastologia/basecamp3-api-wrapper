# A model for Basecamp's CampfireLine
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/campfires.md#campfires For more information, see the official Basecamp3 API documentation for Campfires}
class Basecamp3::CampfireLine < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :content

  REQUIRED_FIELDS = %w(content)

  # Returns a paginated list of campfire lines.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the campfire
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::CampfireLine>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/chats/#{parent_id}/lines", params, Basecamp3::CampfireLine)
  end

  # Returns the campfire line.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the campfire
  # @param [Integer] id the id of the campfire line
  #
  # @return [Basecamp3::CampfireLine]
  def self.find(bucket_id, parent_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/chats/#{parent_id}/lines/#{id}", {}, Basecamp3::CampfireLine)
  end

  # Creates a campfire line.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the campfire
  # @param [Hash] data the data to create a campfire line with
  # @option params [Integer] :content (required) the body of the campfire line
  #
  # @return [Basecamp3::CampfireLine]
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/chats/#{parent_id}/lines", data, Basecamp3::CampfireLine)
  end
end