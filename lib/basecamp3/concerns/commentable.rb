# A concern for commentable models
module Basecamp3
  module Concerns
    module Commentable
      attr_accessor :comments_count

      # Returns the related comments.
      #
      # @return [Array<Basecamp3::Comment>]
      def comments
        @mapped_comments ||= Basecamp3::Comment.all(bucket.id, id)
      end
    end
  end
end