# frozen_string_literal: true

require_relative 'action'
require_relative 'arguments'
require_relative 'context'
require_relative 'indexed_validator'

module Problems
  # An Action with arguments refering to an entity context.
  class ActionWithArguments < Action
    attr_accessor :context

    def initialize(handler, action, &block)
      super(handler, action)

      @context = Context.new
      @arguments_context = Arguments.new(&block)
      @arguments_context.arguments.each { |arg, index| @context.property(index, arg.entity) }
      @arguments_context.validators.each { |validator| validations.add_child(validator) }
    end

    def arguments(*args)
      @context.build(*args)
    end
  end
end
