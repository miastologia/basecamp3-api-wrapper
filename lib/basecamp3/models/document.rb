class Basecamp3::Document < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable
  include Basecamp3::Concerns::Recordingable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :content,
                :comments_count

  REQUIRED_FIELDS = %w(title content)

  ##
  # Optional query parameters:
  #
  # status    - when set to archived or trashed, will return archived or trashed to-dos that are in this list
  # completed - when set to true, will only return to-dos that are completed. Can be combined with the status parameter.
  # page      - to paginate results
  #
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/vaults/#{parent_id}/documents", params, Basecamp3::Document)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/documents/#{id}", {}, Basecamp3::Document)
  end

  ##
  # Required parameters:
  # title   - the title of the document
  # content - the body of the document
  #
  # Optional parameters:
  # status  - set to active to publish immediately
  #
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/vaults/#{parent_id}/documents", data, Basecamp3::Document)
  end

  ##
  # Required parameters:
  # title   - the title of the document
  # content - the body of the document
  #
  # Optional parameters:
  # status  - set to active to publish immediately
  #
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/documents/#{id}", data, Basecamp3::Document)
  end
end