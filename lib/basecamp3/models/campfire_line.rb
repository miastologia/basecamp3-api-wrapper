class Basecamp3::CampfireLine < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :content

  REQUIRED_FIELDS = %w(content)

  ##
  # Optional query parameters:
  # page - to paginate results
  #
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/chats/#{parent_id}/lines", params, Basecamp3::CampfireLine)
  end

  def self.find(bucket_id, parent_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/chats/#{parent_id}/lines/#{id}", {}, Basecamp3::CampfireLine)
  end

  ##
  # Required parameters:
  # content - the plain text body for the Campfire line
  #
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/chats/#{parent_id}/lines", data, Basecamp3::CampfireLine)
  end
end