# frozen_string_literal: true

require_relative 'action'
require_relative 'context'

module Problems
  # An Action with arguments refering to an entity context.
  class ActionWithArguments < Action
    def initialize(handler, action, &block)
      super(handler, action)

      validations.evaluate(&block)
      argument_validators.each_with_index { |arg, index| context.property(index, arg.entity) }
    end

    def context
      @context ||= Context.new
    end

    def arguments(*args)
      @context.build(*args)
    end

    def argument_validators
      validations.children(:argument)
    end

    def all_validators
      validations.children
    end
  end
end
