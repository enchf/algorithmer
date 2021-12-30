# frozen_string_literal: true

require 'toolcase'

module Problems
  # Abstraction of an executable action.
  class Action
    include Toolcase::Registry

    attr_reader :action, :handler

    def initialize(handler, action)
      @handler = handler
      @action = action
    end

    def execute(*args)
      instance = handler.new
      instance.send(action, *args)
    end

    def accept?(*args)
      validators.all? { |validator| validator.valid?(*args) }
    end

    def validators
      registries
    end
  end
end
