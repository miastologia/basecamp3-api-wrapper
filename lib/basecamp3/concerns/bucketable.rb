module Basecamp3
  module Concerns
    module Bucketable
      def bucket
        return nil if @bucket.nil?

        klass = TypeMapper.map(@bucket['type'])
        @mapped_bucket ||= klass.new(@bucket)
      end
    end
  end
end