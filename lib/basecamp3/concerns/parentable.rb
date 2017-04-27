module Basecamp3
  module Concerns
    module Parentable
      def parent
        return nil if @parent.nil?

        klass = TypeMapper.map(@parent['type'])
        @mapped_parent ||= klass.new(@bucket)
      end
    end
  end
end