# frozen_string_literal: true

require 'problems/validation/validator'

module Problems
  # Abstraction of an executable action.
  class Action
    attr_reader :name

    def initialize(handler, action)
      @handler = handler
      @action = action
      @name = action
    end

    def execute(*args)
      @handler.new.send(@action, *arguments(*args))
    end

    def accept?(*args)
      validations.valid?(*args)
    end

    def arguments(*args)
      args
    end

    def validations
      @validations ||= Validator.new
    end
  end
end
