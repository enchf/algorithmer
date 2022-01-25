# frozen_string_literal: true

require 'problems/validation/predicates'

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

    def next_index
      validations.size
    end

    def all_validators
      validations.children
    end

    # Methods to add validators to arguments
    def varargs(**config, &block)
      config[:arguments] = Validator.tail(next_index)
      config_per_argument = config.clone.tap { |cfg| cfg[:arguments] = Validator.indexed_argument(0) }
      validator_per_argument = Validator.new(**config_per_argument).evaluate(&block)
      validator = Validator.new(**config) do |*args|
        args.all? { |argument| validator_per_argument.valid?(argument) }
      end
      validations.add_child(validator)
    end

    # Integrate predicates to validate arguments
    Predicates.all.each do |method|
      executor = Object.new.extend(Predicates)
      define_method(method) do |*args, **config, &block|
        config[:arguments] = Validator.indexed_argument(next_index)
        validator = executor.send(method, *args, **config, &block)
        validations.add_child(validator)
      end
    end
  end
end
