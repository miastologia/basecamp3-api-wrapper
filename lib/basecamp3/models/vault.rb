# A model for Basecamp's Vault
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/vaults.md#vaults For more information, see the official Basecamp3 API documentation for Vaults}
class Basecamp3::Vault < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :documents_count,
                :uploads_count,
                :vaults_count

  REQUIRED_FIELDS = %w(title)

  # Returns a list of related documents.
  #
  # @return [Array<Basecamp3::Document>]
  def documents
    @mapped_documents ||= Basecamp3::Document.all(bucket.id, id)
  end

  # Returns a list of related vaults.
  #
  # @return [Array<Basecamp3::Vault>]
  def vaults
    @mapped_vaults ||= Basecamp3::Vault.all(bucket.id, id)
  end

  # Returns a paginated list of active vaults.
  #
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::Vault>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/vaults/#{parent_id}/vaults", params, Basecamp3::Vault)
  end

  # Returns the vault.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the vault
  #
  # @return [Basecamp3::Vault]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/vaults/#{id}", {}, Basecamp3::Vault)
  end

  # Creates a vault
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the parent
  # @param [Hash] data the data to create a vault with
  # @option params [String] :title (required) the name of the vault
  #
  # @return [Basecamp3::Vault]
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/vaults/#{parent_id}/vaults", data, Basecamp3::Vault)
  end

  # Updates the vault
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the vault
  # @param [Hash] data the data to update the vault with
  # @option params [String] :title (required) the name of the vault
  #
  # @return [Basecamp3::Vault]
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/vaults/#{id}", data, Basecamp3::Vault)
  end
end