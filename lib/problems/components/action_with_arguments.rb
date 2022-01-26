# frozen_string_literal: true

require 'problems/validation/predicates'

require_relative 'action'
require_relative 'context'

module Problems
  # An Action with arguments refering to an entity context.
  class ActionWithArguments < Action
    NON_ARGUMENT_PREDICATES = %i[reserved_word].freeze

    def initialize(handler, action, &block)
      super(handler, action)

      instance_eval(&block)
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

    def size_valid?(size)
      min = 0
      max = 0

      validator_types.each do |type|
        min += 1 unless %i[optional varargs].include?(type)
        max = type == :varargs ? Float::INFINITY : max + 1
      end

      size >= min && size <= max
    end

    def validations
      action = self
      @validations ||= Validator.new do |*args|
        action.size_valid?(args.size)
      end
    end

    # Methods to add validators to arguments

    def varargs(**config, &block)
      @varargs = true
      config[:arguments] = Validator.tail(next_index)
      config_per_argument = config.clone.tap { |cfg| cfg[:arguments] = Validator.indexed_argument(0) }
      validator_per_argument = Validator.new(**config_per_argument).evaluate(&block)
      validator = Validator.new(**config) do |*args|
        args.all? { |argument| validator_per_argument.valid?(argument) }
      end
      validations.add_child(validator)
      validator_types << :varargs
    end

    # Integrate predicates to validate arguments
    Predicates.all.each do |method|
      executor = Object.new.extend(Predicates)
      define_method(method) do |*args, **config, &block|
        validator = executor.send(method, *args, **config, &block)
        argument = !NON_ARGUMENT_PREDICATES.include?(method)
        add_validator(validator, argument: argument, type: method)
      end
    end

    def add_validator(validator, argument: true, type: :custom)
      validator.arguments = Validator.indexed_argument(next_index)
      tag = argument ? :argument : nil
      validations.add_child(validator, tag: tag)
      validator_types << type
    end

    private

    def validator_types
      @validator_types ||= []
    end
  end
end
