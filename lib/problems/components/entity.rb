# frozen_string_literal: true

require 'toolcase'
require 'problems/validation/validator_branch'

module Problems
  # Base entity handler.
  class Entity
    extend Toolcase::Registry

    class << self
      def action(*names, &block)
        names.each do |action_name|
          validator = arguments(&block)
          register validator, id: action_name
        end
      end

      def arguments(&block)
        ValidatorBranch.for_arguments(&block)
      end

      def actions
        identifiers
      end
    end
  end
end
