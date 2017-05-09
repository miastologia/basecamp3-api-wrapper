# A model for Basecamp's TODO Set
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/todosets.md#to-do-sets For more information, see the official Basecamp3 API documentation for TODO sets}
class Basecamp3::TodoSet < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :name,
                :todolists_count,
                :completed,
                :completed_ratio

  # Returns a list of related todo lists.
  #
  # @return [Array<Basecamp3::TodoList>]
  def todo_lists
    @mapped_todo_lists ||= Basecamp3::TodoList.all(bucket.id, id)
  end

  # Returns the TODO set.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the TODO set
  #
  # @return [Basecamp3::TodoSet]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/todosets/#{id}", {}, Basecamp3::TodoSet)
  end
end