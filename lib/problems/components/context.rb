# frozen_string_literal: true

module Problems
  # Action execution context.
  class Context
    def initialize
      @properties = {}
    end

    def property(entity, index)
      @properties[index] = entity
    end

    def build(*args)
      @properties.sort_by(&:first).map do |index, _|
        # TODO - Object to extract formal values of an entity
        args[index]
      end
    end

    def fetch(entity, args, default = nil)
      @extractor.fetch(entity).call(args)
    end
  end
end
