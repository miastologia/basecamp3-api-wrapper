class Basecamp3::Vault < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :documents_count,
                :uploads_count,
                :vaults_count

  REQUIRED_FIELDS = %w(title)

  ##
  # Optional query parameters:
  # page - to paginate results
  #
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/vaults/#{parent_id}/vaults", params, Basecamp3::Vault)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/vaults/#{id}", {}, Basecamp3::Vault)
  end

  ##
  # Required parameters:
  # title - name of the to-do list
  #
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/vaults/#{parent_id}/vaults", data, Basecamp3::Vault)
  end

  ##
  # Required parameters:
  # title - name of the to-do list
  #
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/vaults/#{id}", data, Basecamp3::Vault)
  end
end