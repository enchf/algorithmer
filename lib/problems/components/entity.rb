# frozen_string_literal: true

require 'toolcase'

require_relative 'arguments'

module Problems
  # Base entity handler.
  class Entity
    extend Toolcase::Registry

    class << self
      def action(*names, &block)
        action_names.each do |action_name|
          validator = arguments(&block)
          register validator, id: action_name
        end
      end

      def arguments(&block)
        Arguments.new(&block)
      end

      def actions
        identifiers
      end
    end
  end
end
