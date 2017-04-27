class Basecamp3::Schedule < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :entries_count

  def entries
    @mapped_entries ||= Basecamp3::ScheduleEntry.all(bucket.id, id)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/schedules/#{id}", {}, Basecamp3::Schedule)
  end
end