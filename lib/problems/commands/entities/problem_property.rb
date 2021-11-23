# frozen_string_literal: true

require_relative 'project_property'

module Commands
  # Base entity class for objects related to a problem.
  class ProblemProperty < ProjectProperty
    FOR_KEYWORD = 'for'

    # TODO: Validates if a problem exists in the project
    validator { |*_| true }

    def self.for_validator(position)
      proc { |*args| args[position] == FOR_KEYWORD }
    end
  end
end
