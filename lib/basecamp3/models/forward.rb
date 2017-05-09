# A model for Basecamp's Forward
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/forwards.md#forwards For more information, see the official Basecamp3 API documentation for Forwards}
class Basecamp3::Forward < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable
  include Basecamp3::Concerns::Recordingable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :subject,
                :content,
                :from,
                :replies_count

  # Returns a paginated list of active forwards.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the inbox
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::Forward>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/inboxes/#{parent_id}/forwards", params, Basecamp3::Forward)
  end

  # Returns the forward.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the forward
  #
  # @return [Basecamp3::Forward]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/inbox_forwards/#{id}", {}, Basecamp3::Forward)
  end
end