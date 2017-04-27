class Basecamp3::TodoList < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :name,
                :description,
                :comments_count,
                :completed,
                :completed_ratio

  REQUIRED_FIELDS = %w(name)

  ##
  # Optional query parameters:
  # status - when set to archived or trashed, will return archived or trashed to-do lists that are in this to-do set.
  # page   - to paginate results
  #
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/todosets/#{parent_id}/todolists", params, Basecamp3::TodoList)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/todolists/#{id}", {}, Basecamp3::TodoList)
  end

  ##
  # Required parameters:
  # name - name of the to-do list
  #
  # Optional parameters:
  # description - containing information about the to-do list
  #
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/todosets/#{parent_id}/todolists", data, Basecamp3::TodoList)
  end

  ##
  # Required parameters:
  # name - name of the to-do list
  #
  # Optional parameters:
  # description - containing information about the to-do list
  #
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/todolists/#{id}", data, Basecamp3::TodoList)
  end

  def self.delete(bucket_id, id)
    Basecamp3.request.put("/buckets/#{bucket_id}/recordings/#{id}/status/trashed")
  end
end