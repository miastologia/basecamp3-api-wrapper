module Basecamp3
  module Concerns
    module Commentable
      attr_accessor :comments_count

      def comments
        @mapped_comments ||= Basecamp3::Comment.all(bucket.id, id)
      end
    end
  end
end