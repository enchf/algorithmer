# frozen_string_literal: true

require_relative 'action'

module Problems
  # Action with explicit validators.
  class ActionWithValidators < Action
    def initialize(handler, action, &block)
      super(handler, action)
      instance_eval(&block) unless block.nil?
    end

    def add(*validators)
      validators.each { |validator| validations.add_child(validator) }
    end
  end
end
