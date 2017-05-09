# A model for Basecamp's Schedule Entry
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/schedule_entries.md#schedule-entries For more information, see the official Basecamp3 API documentation for Schedule entries}
class Basecamp3::ScheduleEntry < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable
  include Basecamp3::Concerns::Recordingable
  include Basecamp3::Concerns::Commentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :summary,
                :description,
                :starts_at,
                :ends_at,
                :all_day

  REQUIRED_FIELDS = %w(summary starts_at ends_at)

  # Returns a list of related participants.
  #
  # @return [Array<Basecamp3::Person>]
  def participants
    return [] if @participants.nil?

    @mapped_participants ||= @participants.map{ |p| Basecamp3::Person.new(p) }
  end

  # Returns a paginated list of active schedule entries.
  #
  # @param [Hash] params additional parameters
  # @option params [Integer] :page (optional) to paginate results
  # @option params [Integer] :status (optional) when set to archived or trashed, will return archived or trashed schedule entries that are in this schedule
  #
  # @return [Array<Basecamp3::ScheduleEntry>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/schedules/#{parent_id}/entries", params, Basecamp3::ScheduleEntry)
  end

  # Returns the schedule entry.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the schedule entry
  #
  # @return [Basecamp3::ScheduleEntry]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/schedule_entries/#{id}", {}, Basecamp3::ScheduleEntry)
  end


  # Creates a schedule entry.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] parent_id the id of the schedule
  # @param [Hash] data the data to create a schedule entry with
  # @option params [Integer] :summary (required) what this schedule entry is about
  # @option params [Integer] :starts_at (required) timestamp for when this schedule entry begins
  # @option params [Integer] :ends_at (required) timestamp for when this schedule entry ends
  # @option params [String] :description (optional) containing more information about the schedule entry
  # @option params [Array<Integer>] :participant_ids (optional) an array of people IDs that will participate in this entry
  # @option params [Boolean] :all_day (optional) when set to true, the schedule entry will not have a specific start or end time,
  # and instead will be held for the entire day or days denoted in starts_at and ends_at
  # @option params [Boolean] :notify (optional) when set to true, will notify the participants about the entry
  #
  # @return [Basecamp3::ScheduleEntry]
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/schedules/#{parent_id}/entries", data, Basecamp3::ScheduleEntry)
  end

  # Updates the schedule entry.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the schedule entry
  # @param [Hash] data the data to update the schedule entry with
  # @option params [Integer] :summary (required) what this schedule entry is about
  # @option params [Integer] :starts_at (required) timestamp for when this schedule entry begins
  # @option params [Integer] :ends_at (required) timestamp for when this schedule entry ends
  # @option params [String] :description (optional) containing more information about the schedule entry
  # @option params [Array<Integer>] :participant_ids (optional) an array of people IDs that will participate in this entry
  # @option params [Boolean] :all_day (optional) when set to true, the schedule entry will not have a specific start or end time,
  # and instead will be held for the entire day or days denoted in starts_at and ends_at
  # @option params [Boolean] :notify (optional) when set to true, will notify the participants about the entry
  #
  # @return [Basecamp3::ScheduleEntry]
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/schedule_entries/#{id}", data, Basecamp3::ScheduleEntry)
  end
end