class Basecamp3::Campfire < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :topic

  REQUIRED_FIELDS = %w(topic)

  def lines
    @mapped_lines ||= Basecamp3::CampfireLine.all(bucket.id, id)
  end

  ##
  # Optional query parameters:
  # page - to paginate results
  #
  def self.all(params = {})
    Basecamp3.request.get("/chats", params, Basecamp3::Campfire)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/chats/#{id}", {}, Basecamp3::Campfire)
  end
end