# frozen_string_literal: true

require 'toolcase'
require_relative 'action_builder'

module Problems
  # Base entity handler.
  class Entity
    extend Toolcase::Registry

    class << self
      alias actions registries

      def action(*action_names, &block)
        action_names.each do |action_name|
          ActionBuilder.new(self, action_name)
                       .build(&block)
                       .tap { |it| register(it, id: action_name) }
        end
      end
    end
  end
end
