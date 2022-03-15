# frozen_string_literal: true

require 'toolcase'

require_relative 'argument_provider'
require_relative 'validator'

module Problems
  # Builder to create configurable validators.
  class ValidatorBuilder
    ALWAYS_VALID = proc { |*_| true }

    def initialize
      @reductor = :all?
      @predicate = ALWAYS_VALID
      @arguments = ArgumentProvider.all
      @registry = Object.extend(Toolcase::Registry)
    end

    def all
      tap { @reductor = :all? }
    end

    def any
      tap { @reductor = :any? }
    end

    def predicate(&block)
      tap { @predicate = block if block_given? }
    end

    def append(validator)
      tap { @registry.register(validator) }
    end

    def argument_provider(provider)
      tap { @arguments = provider }
    end

    def build
      Validator.new(@reductor, @arguments, @registry.registries, &@predicate)
    end
  end
end
