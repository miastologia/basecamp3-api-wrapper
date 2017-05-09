# A concern for bucketable models
module Basecamp3
  module Concerns
    module Bucketable

      # Returns the related bucket.
      #
      # @return [Basecamp3::Model]
      def bucket
        return nil if @bucket.nil?

        klass = TypeMapper.map(@bucket['type'])
        @mapped_bucket ||= klass.new(@bucket)
      end
    end
  end
end