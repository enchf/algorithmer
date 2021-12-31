# frozen_string_literal: true

require 'toolcase'
require_relative 'validator'

module Problems
  # Abstraction of an executable action.
  class Action
    attr_reader :action, :handler, :root_validator

    def initialize(handler, action)
      @handler = handler
      @action = action
      @root_validator = Validator.new
    end

    def execute(*args)
      handler.new.send(action, *args)
    end

    def accept?(*args)
      root_validator.valid?(*args)
    end

    def add_validations(&block)
      root_validator.instance_eval(&block)
    end
  end
end
