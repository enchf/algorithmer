# frozen_string_literal: true

require 'problems/common/validator'

module Problems
  # Abstraction of an executable action.
  class Action
    attr_accessor :validations

    def initialize(handler, action)
      @handler = handler
      @action = action
      @validations = Validator.new
    end

    def execute(*args)
      @handler.new.send(@action, *arguments(*args))
    end

    def accept?(*args)
      @validations.valid?(*args)
    end

    def arguments(*args)
      args
    end
  end
end
