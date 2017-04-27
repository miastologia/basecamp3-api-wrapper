module Basecamp3
  module Concerns
    module Creatorable
      def creator
        return nil if @creator.nil?

        @mapped_creator ||= Basecamp3::Person.new(@creator)
      end
    end
  end
end