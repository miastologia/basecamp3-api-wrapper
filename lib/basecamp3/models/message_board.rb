class Basecamp3::MessageBoard < Basecamp3::Model
  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :messages_count

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/message_boards/#{id}", {}, Basecamp3::MessageBoard)
  end
end