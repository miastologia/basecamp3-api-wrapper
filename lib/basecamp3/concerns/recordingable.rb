module Basecamp3
  module Concerns
    module Recordingable
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def delete(bucket_id, id)
          Basecamp3.request.put("/buckets/#{bucket_id}/recordings/#{id}/status/trashed")
        end
      end
    end
  end
end