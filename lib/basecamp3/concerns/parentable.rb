# A concern for parentable models
module Basecamp3
  module Concerns
    module Parentable

      # Returns the parent.
      #
      # @return [Basecamp3::Model]
      def parent
        return nil if @parent.nil?

        klass = TypeMapper.map(@parent['type'])
        @mapped_parent ||= klass.new(@parent)
      end
    end
  end
end
