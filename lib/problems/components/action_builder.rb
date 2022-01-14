# frozen_string_literal: true

require_relative 'action_without_args'
require_relative 'action_with_arguments'
require_relative 'action_with_validators'

module Problems
  # Action type abstract factory.
  class ActionBuilder
    extend Toolcase::Registry

    def self.add(action_class, method_name)
      register action_class, id: method_name

      define_method(method_name) do |&block|
        ActionBuilder[method_name].new(@handler, @action, &block)
      end
    end

    add ActionWithoutArgs,    :empty_args
    add ActionWithArguments,  :arguments
    add ActionWithValidators, :explicit

    def initialize(handler, action)
      @handler = handler
      @action = action
    end
  end
end
