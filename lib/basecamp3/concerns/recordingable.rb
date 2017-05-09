# A concern for recordingable models
module Basecamp3
  module Concerns
    module Recordingable
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        # Deletes the record.
        #
        # @param [Integer] bucket_id the id of the bucket
        # @param [Integer] id the id of the record
        #
        # @return [Boolean]
        def delete(bucket_id, id)
          Basecamp3.request.put("/buckets/#{bucket_id}/recordings/#{id}/status/trashed")
        end
      end
    end
  end
end