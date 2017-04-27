class Basecamp3::Schedule < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :entries_count

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/schedules/#{id}", {}, Basecamp3::Schedule)
  end
end