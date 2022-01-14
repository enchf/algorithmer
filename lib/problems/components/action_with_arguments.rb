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
      @arguments_context = Arguments.new
                                    .tap { |builder| builder.instance_eval(&block) unless block.nil? }

      build_context
      build_validators
    end

    def arguments(*args)
      @context.build(*args)
    end

    private

    def build_context
      @arguments_context.arguments { |arg, index| @context.property(index, arg.entity) }
    end

    def build_validators
      @arguments_context.each_with_index
                        .map { |validator, index| IndexedValidator.new(validator, index, @context) }
                        .each { |indexed_validator| validations.add_child(indexed_validator) }
    end
  end
end
