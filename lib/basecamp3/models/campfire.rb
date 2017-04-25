class Basecamp3::Campfire < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :topic

  REQUIRED_FIELDS = %w(topic)

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