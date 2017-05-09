# A model for Basecamp's Document
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/documents.md#documents For more information, see the official Basecamp3 API documentation for Documents}
class Basecamp3::Document < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable
  include Basecamp3::Concerns::Recordingable
  include Basecamp3::Concerns::Commentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :content

  REQUIRED_FIELDS = %w(title content)

  # Returns a paginated list of active documents.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the parent
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::Document>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/vaults/#{parent_id}/documents", params, Basecamp3::Document)
  end

  # Returns the document.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the document
  #
  # @return [Basecamp3::Document]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/documents/#{id}", {}, Basecamp3::Document)
  end

  # Creates a document.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the parent
  # @param [Hash] data the data to create a Document with
  # @option params [Integer] :title (required) the title of the document
  # @option params [String] :content (required) the body of the document
  # @option params [String] :status (optional) set to active to publish immediately
  #
  # @return [Basecamp3::Document]
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/vaults/#{parent_id}/documents", data, Basecamp3::Document)
  end

  # Updates the document.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the document
  # @param [Hash] data the data to update the document with
  # @option params [Integer] :title (required) the title of the document
  # @option params [String] :content (required) the body of the document
  # @option params [String] :status (optional) set to active to publish immediately
  #
  # @return [Basecamp3::Document]
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/documents/#{id}", data, Basecamp3::Document)
  end
end