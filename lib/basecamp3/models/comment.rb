class Basecamp3::Comment < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :content,
                :parent_id,
                :bucket_id

  REQUIRED_FIELDS = %w(content)

  ##
  # Optional query parameters:
  #
  # page - to paginate results
  #
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/recordings/#{parent_id}/comments", params, Basecamp3::Comment)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/comments/#{id}", {}, Basecamp3::Comment)
  end

  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/recordings/#{parent_id}/comments", data, Basecamp3::Comment)
  end

  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/comments/#{id}", data, Basecamp3::Comment)
  end

  def self.delete(bucket_id, id)
    Basecamp3.request.put("/buckets/#{bucket_id}/recordings/#{id}/status/trashed")
  end
end