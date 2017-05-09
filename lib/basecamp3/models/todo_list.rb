# A model for Basecamp's TODO List
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/todolists.md#to-do-lists For more information, see the official Basecamp3 API documentation for TODO lists}
class Basecamp3::TodoList < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable
  include Basecamp3::Concerns::Recordingable
  include Basecamp3::Concerns::Commentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :name,
                :description,
                :completed,
                :completed_ratio

  REQUIRED_FIELDS = %w(name)

  # Returns a list of related todos.
  #
  # @return [Array<Basecamp3::Todo>]
  def todos
    @mapped_todos ||= Basecamp3::Todo.all(bucket.id, id)
  end

  # Returns a paginated list of active TODO lists.
  #
  # @param [Hash] params additional parameters
  # @option params [String] :status (optional) when set to archived or trashed, will return archived or trashed to-do lists that are in this to-do list
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::TodoList>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/todosets/#{parent_id}/todolists", params, Basecamp3::TodoList)
  end

  # Returns the TODO list.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the TODO list
  #
  # @return [Basecamp3::TodoList]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/todolists/#{id}", {}, Basecamp3::TodoList)
  end

  # Creates a TODO list.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the TODO set
  # @param [Hash] data the data to create a TODO list with
  # @option params [String] :name (required) the name of the to-do list
  # @option params [String] :description (optional) containing information about the to-do list
  #
  # @return [Basecamp3::TodoList]
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/todosets/#{parent_id}/todolists", data, Basecamp3::TodoList)
  end

  # Updates the TODO list.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the TODO list
  # @param [Hash] data the data to create the TODO list with
  # @option params [String] :name (required) the name of the to-do list
  # @option params [String] :description (optional) containing information about the to-do list
  #
  # @return [Basecamp3::TodoList]
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/todolists/#{id}", data, Basecamp3::TodoList)
  end
end