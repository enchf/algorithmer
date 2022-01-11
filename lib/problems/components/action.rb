# frozen_string_literal: true

require 'toolcase'
require 'problems/common/validator'
require 'problems/components/context'

module Problems
  # Abstraction of an executable action.
  class Action
    attr_reader :action, :handler, :root_validator

    def initialize(handler, action)
      @handler = handler
      @action = action
      @root_validator = Validator.new
      @context = Context.new
      @arguments = nil
    end

    def arguments(&block)
      @arguments = []
      ArgumentValidator.new
                       .yield_self { |it| it.instance_eval(&block) }
                       .children
                       .each_with_index do |validator, index|
        @root_validator.add_child(IndexedValidator.new(validator, index).with_context(@context))
        next unless validator.argument?

        @context.add(validator.entity, index)
        @arguments << index
      end
    end

    def execute(*args)
      action_args = @arguments&.map { |index| args[index] } || args
      handler.new.send(action, *action_args)
    end

    def accept?(*args)
      root_validator.valid?(*args)
    end
  end
end
