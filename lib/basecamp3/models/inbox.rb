# A model for Basecamp's Inbox
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/inboxes.md#inboxes For more information, see the official Basecamp3 API documentation for Inboxes}
class Basecamp3::Inbox < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :forwards_count

  # Returns a list of related forwards.
  #
  # @return [Array<Basecamp3::Forward>]
  def forwards
    @mapped_forwards ||= Basecamp3::Forward.all(bucket.id, id)
  end

  # Returns the inbox.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the inbox
  #
  # @return [Basecamp3::Inbox]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/inboxes/#{id}", {}, Basecamp3::Inbox)
  end
end