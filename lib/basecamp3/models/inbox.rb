class Basecamp3::Inbox < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :forwards_count

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/inboxes/#{id}", {}, Basecamp3::Inbox)
  end
end