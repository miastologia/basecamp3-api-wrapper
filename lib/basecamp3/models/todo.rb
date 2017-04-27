class Basecamp3::Todo < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable
  include Basecamp3::Concerns::Recordingable
  include Basecamp3::Concerns::Commentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :content,
                :description,
                :assignee_ids,
                :starts_on,
                :due_on

  REQUIRED_FIELDS = %w(content)

  ##
  # Optional query parameters:
  #
  # status    - when set to archived or trashed, will return archived or trashed to-dos that are in this list
  # completed - when set to true, will only return to-dos that are completed. Can be combined with the status parameter.
  # page      - to paginate results
  #
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/todolists/#{parent_id}/todos", params, Basecamp3::Todo)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/todos/#{id}", {}, Basecamp3::Todo)
  end

  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/todolists/#{parent_id}/todos", data, Basecamp3::Todo)
  end

  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/todos/#{id}", data, Basecamp3::Todo)
  end

  def self.complete(bucket_id, id)
    Basecamp3.request.post("/buckets/#{bucket_id}/todos/#{id}/completion")
  end

  def self.incomplete(bucket_id, id)
    Basecamp3.request.delete("/buckets/#{bucket_id}/todos/#{id}/completion")
  end
end