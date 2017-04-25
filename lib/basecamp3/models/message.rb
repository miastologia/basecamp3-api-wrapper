class Basecamp3::Message < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :subject,
                :content,
                :comments_count

  REQUIRED_FIELDS = %w(subject)

  ##
  # Optional query parameters:
  # page - to paginate results
  #
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/message_boards/#{parent_id}/messages", params, Basecamp3::Message)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/messages/#{id}", {}, Basecamp3::Message)
  end

  ##
  # Required parameters:
  # subject - the title of the message
  # status  - set to active to publish immediately
  #
  # Optional parameters:
  # content - the body of the message
  # category_id - to set a type for the message
  #
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/message_boards/#{parent_id}/messages", data, Basecamp3::Message)
  end

  ##
  # Required parameters:
  # subject - the title of the message
  # status  - set to active to publish immediately
  #
  # Optional parameters:
  # content - the body of the message
  # category_id - to set a type for the message
  #
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/messages/#{id}", data, Basecamp3::Message)
  end

  def self.delete(bucket_id, id)
    Basecamp3.request.put("/buckets/#{bucket_id}/recordings/#{id}/status/trashed")
  end
end