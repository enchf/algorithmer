# frozen_string_literal: true

module Problems
  # Action execution context.
  class Context
    def initialize
      @properties = {}
    end

    def property(entity, index)
      @properties[index] = entity unless entity.nil?
    end

    def build(*args)
      args.map do |argument_values, index|
        @properties.key?(index) ? extract(@properties[index], argument_values) : argument_values
      end.flatten(1)
    end

    private

    def extract(_entity, values)
      values
    end
  end
end
