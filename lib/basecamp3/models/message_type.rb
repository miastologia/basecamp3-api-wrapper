class Basecamp3::MessageType < Basecamp3::Model
  attr_accessor :id,
                :created_at,
                :updated_at,
                :name,
                :icon

  REQUIRED_FIELDS = %w(name icon)

  def self.all(bucket_id)
    Basecamp3.request.get("/buckets/#{bucket_id}/categories", {}, Basecamp3::MessageType)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/categories/#{id}", {}, Basecamp3::MessageType)
  end

  ##
  # Required parameters:
  # name
  # icon
  #
  def self.create(bucket_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/categories", data, Basecamp3::MessageType)
  end

  ##
  # Required parameters:
  # name
  # icon
  #
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/categories/#{id}", data, Basecamp3::MessageType)
  end

  def self.delete(bucket_id, id)
    Basecamp3.request.delete("/buckets/#{bucket_id}/categories/#{id}")
  end
end