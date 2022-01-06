# frozen_string_literal: true

require 'toolcase'
require_relative 'action'

module Problems
  # Base entity handler.
  class Entity
    extend Toolcase::Registry

    class << self
      alias actions registries

      def validations(&block)
        @validations = block if block_given?
        defined?(@validations) ? @validations : proc {}
      end

      def action(action_name, &block)
        handler = Action.new(self, action_name)
        handler.add_validations(&validations)
        handler.add_validations(&block)
        register(handler, id: action_name)
      end
    end
  end
end
