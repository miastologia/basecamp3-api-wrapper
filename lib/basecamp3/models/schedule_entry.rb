class Basecamp3::ScheduleEntry < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :summary,
                :description,
                :starts_at,
                :ends_at,
                :all_day,
                :comments_count

  REQUIRED_FIELDS = %w(summary starts_at ends_at)

  ##
  # Optional query parameters:
  # status - when set to archived or trashed, will return archived or trashed schedule entries that are in this schedule
  # page   - to paginate results
  #
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/schedules/#{parent_id}/entries", params, Basecamp3::ScheduleEntry)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/schedule_entries/#{id}", {}, Basecamp3::ScheduleEntry)
  end

  ##
  # Required parameters:
  # summary   - what this schedule entry is about
  # starts_at - timestamp for when this schedule entry begins
  # ends_at   - timestamp for when this schedule entry ends
  #
  # Optional parameters:
  # description     - containing more information about the schedule entry
  # participant_ids - an array of people IDs that will participate in this entry
  # all_day         - when set to true, the schedule entry will not have a specific start or end time,
  #                   and instead will be held for the entire day or days denoted in starts_at and ends_at
  # notify          - when set to true, will notify the participants about the entry
  #
  def self.create(bucket_id, parent_id, data)
    self.validate_required(data)
    Basecamp3.request.post("/buckets/#{bucket_id}/schedules/#{parent_id}/entries", data, Basecamp3::ScheduleEntry)
  end

  ##
  # Required parameters:
  # summary   - what this schedule entry is about
  # starts_at - timestamp for when this schedule entry begins
  # ends_at   - timestamp for when this schedule entry ends
  #
  # Optional parameters:
  # description     - containing more information about the schedule entry
  # participant_ids - an array of people IDs that will participate in this entry
  # all_day         - when set to true, the schedule entry will not have a specific start or end time,
  #                   and instead will be held for the entire day or days denoted in starts_at and ends_at
  # notify          - when set to true, will notify the participants about the entry
  #
  def self.update(bucket_id, id, data)
    self.validate_required(data)
    Basecamp3.request.put("/buckets/#{bucket_id}/schedule_entries/#{id}", data, Basecamp3::ScheduleEntry)
  end

  def self.delete(bucket_id, id)
    Basecamp3.request.put("/buckets/#{bucket_id}/recordings/#{id}/status/trashed")
  end
end