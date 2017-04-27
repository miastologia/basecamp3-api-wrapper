class Basecamp3::Forward < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :subject,
                :content,
                :from,
                :replies_count

  ##
  # Optional query parameters:
  # page - to paginate results
  #
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/inboxes/#{parent_id}/forwards", params, Basecamp3::Forward)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/inbox_forwards/#{id}", {}, Basecamp3::Forward)
  end

  def self.delete(bucket_id, id)
    Basecamp3.request.put("/buckets/#{bucket_id}/recordings/#{id}/status/trashed")
  end
end