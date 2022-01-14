# frozen_string_literal: true

module Problems
  # Action execution context.
  class Context
    # Class for instructions to build context from args.
    class Builder
      def initialize
        @map = {}
      end

      def property(entity, index)
        tap { @map[index] = entity }
      end

      def build
        Context.new(@map.map { |index, entity| [entity.name, proc { |*args| entity.fetch(args[index]) }] }.to_h)
      end
    end

    private

    def initialize(extractor)
      @extractor = extractor
    end

    def fetch(entity, args, default = nil)
      @extractor.fetch(entity).call(args)
    end
  end
end
