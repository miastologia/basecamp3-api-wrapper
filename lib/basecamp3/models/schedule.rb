# A model for Basecamp's Schedule
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/schedules.md#schedules For more information, see the official Basecamp3 API documentation for Schedules}
class Basecamp3::Schedule < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :entries_count

  # Returns a list of related entries.
  #
  # @return [Array<Basecamp3::ScheduleEntry>]
  def entries
    @mapped_entries ||= Basecamp3::ScheduleEntry.all(bucket.id, id)
  end

  # Returns the schedule.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the schedule
  #
  # @return [Basecamp3::Schedule]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/schedules/#{id}", {}, Basecamp3::Schedule)
  end
end