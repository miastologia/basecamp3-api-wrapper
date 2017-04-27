class Basecamp3::MessageBoard < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :title,
                :messages_count

  def messages
    @mapped_messages ||= Basecamp3::Message.all(bucket.id, id)
  end

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/message_boards/#{id}", {}, Basecamp3::MessageBoard)
  end
end