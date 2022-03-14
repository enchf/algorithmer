# frozen_string_literal: true

require 'toolcase'
require_relative 'validator'

# Builder to create configurable validators.
class ValidatorBuilder
  ALWAYS_VALID = proc { |*_| true }

  def initialize
    @reductor = :all?
    @predicate = ALWAYS_VALID
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

  def build
    Validator.new(@reductor, @registry.registries, &@predicate)
  end
end
