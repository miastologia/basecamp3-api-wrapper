# A concern for creatorable models
module Basecamp3
  module Concerns
    module Creatorable

      # Returns the creator.
      #
      # @return [Basecamp3::Person]
      def creator
        return nil if @creator.nil?

        @mapped_creator ||= Basecamp3::Person.new(@creator)
      end
    end
  end
end