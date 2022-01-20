# frozen_string_literal: true

require_relative 'action'
require_relative 'validator'

module Problems
  # An action without arguments
  class ActionWithoutArgs < Action
    EMPTY_ARGS_VALIDATOR = Validator.new { |*args| args.empty? }

    def initialize(handler, action)
      super(handler, action)
      validations.add_child(EMPTY_ARGS_VALIDATOR)
    end

    def arguments
      []
    end
  end
end
