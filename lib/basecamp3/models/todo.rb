# A model for Basecamp's TODO
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#to-dos For more information, see the official Basecamp3 API documentation for TODOs}
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
                :starts_on,
                :due_on

  REQUIRED_FIELDS = %w(content)

  # Returns a list of related assignees.
  #
  # @return [Array<Basecamp3::Person>]
  def assignees
    @mapped_assignees ||= @assignees.map{ |a| Basecamp3::Person.new(a) }
  end

  # Returns a paginated list of active TODOs.
  #
  # @param [Hash] params additional parameters
  # @option params [String] :status (optional) when set to archived or trashed, will return archived or trashed to-dos that are in this list
  # @option params [Boolean] :completed (optional) when set to true, will only return to-dos that are completed
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::Todo>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/todolists/#{parent_id}/todos", params, Basecamp3::Todo)
  end

  # Returns the TODO.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the TODO
  #
  # @return [Basecamp3::Todo]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/todos/#{id}", {}, Basecamp3::Todo)
  end

  # Creates a TODO.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the TODO list
  # @param [Hash] data the data to create a TODO with
  # @option params [String] :content (required) for what the to-do is for
  # @option params [String] :description (optional) containing information about the to-do
  # @option params [Array<Integer>] :assignee_ids (optional) an array of people that will be assigned to this to-do
  # @option params [Boolean] :notify (optional) when set to true, will notify the assignees about being assigned
  # @option params [Date] :due_on (optional) a date when the to-do should be completed
  # @option params [Date] :starts_on (optional) allows the to-do to run from this date to the due_on date
  #
  # @return [Basecamp3::Todo]
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/todolists/#{parent_id}/todos", data, Basecamp3::Todo)
  end

  # Updates the TODO.
  #
  # REMEMBER: Pass all existing parameters in addition to those being updated!
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the TODO
  # @param [Hash] data the data to update the TODO with
  # @option params [String] :content (required) for what the to-do is for
  # @option params [String] :description (optional) containing information about the to-do
  # @option params [Array<Integer>] :assignee_ids (optional) an array of people that will be assigned to this to-do
  # @option params [Boolean] :notify (optional) when set to true, will notify the assignees about being assigned
  # @option params [Date] :due_on (optional) a date when the to-do should be completed
  # @option params [Date] :starts_on (optional) allows the to-do to run from this date to the due_on date
  #
  # @return [Basecamp3::Todo]
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/todos/#{id}", data, Basecamp3::Todo)
  end

  # Completes the TODO.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the TODO
  #
  # @return [Boolean]
  def self.complete(bucket_id, id)
    Basecamp3.request.post("/buckets/#{bucket_id}/todos/#{id}/completion")
  end

  # Incompletes the TODO.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the TODO
  #
  # @return [Boolean]
  def self.incomplete(bucket_id, id)
    Basecamp3.request.delete("/buckets/#{bucket_id}/todos/#{id}/completion")
  end
end