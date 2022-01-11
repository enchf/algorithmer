# frozen_string_literal: true

require 'toolcase'
require_relative 'action'

module Problems
  # Base entity handler.
  class Entity
    extend Toolcase::Registry

    class << self
      alias actions registries

      def action(action_name, &block)
        Action.new(self, action_name).yield_self do |it|
          it.instance_eval(&block)
          register(it, id: action_name)
        end
      end
    end
  end
end
