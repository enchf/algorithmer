# frozen_string_literal: true

require_relative 'action'
require_relative 'context'

module Problems
  # An Action with arguments refering to an entity context.
  class ActionWithArguments < Action
    EXCLUDE_FROM_ARGUMENTS = %i[reserved_word empty_args].freeze

    def initialize(handler, action, &block)
      super(handler, action)

      instance_eval(&block)
      argument_validators.each { |instance, index| context.property(instance.entity, index) }
    end

    def context
      @context ||= Context.new
    end

    def arguments(*args)
      context.build(*args)
    end

    def next_index
      validations.size
    end

    def all_validators
      validations.children
    end

    def argument_validators
      all_validators.each_with_index
                    .select { |instance, _| validations.children(:argument).include?(instance) }
    end

    def arity
      return 0..0 if validator_types.include?(:empty_args)

      min = 0
      max = 0

      validator_types.each do |type|
        min += 1 unless %i[optional varargs].include?(type)
        max = type == :varargs ? Float::INFINITY : max + 1
      end

      min..max
    end

    def size_valid?(args)
      arity.include?(args.size)
    end

    def validations
      action = self
      @validations ||= Validator.new do |*args|
        action.size_valid?(args)
      end
    end

    # Methods to add validators to arguments

    def varargs(**config, &block)
      validator = Predicates::EXECUTOR.varargs(next_index, **config, &block)
      validations.add_child(validator, tag: :argument)
      validator_types << :varargs
    end

    def empty_args(**config)
      validator = Predicates::EXECUTOR.empty_args(**config)
      validations.add_child(validator)
      validator_types << :empty_args
    end

    def add_validator(validator, argument: true, type: :custom)
      validator.arguments = Validator.indexed_argument(next_index)
      tag = argument ? :argument : nil
      validator_types << type
      validations.add_child(validator, tag: tag)
    end

    private

    def validator_types
      @validator_types ||= []
    end
  end
end
