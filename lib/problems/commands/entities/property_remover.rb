# frozen_string_literal: true

require_relative 'problem_property'

module Commands
  # Represents a tag assigned to a problem.
  class PropertyRemover < ProblemProperty
    PROPERTIES = %w[title description url].freeze

    validator args_size(3)
    validator { |keyword, *_| PROPERTIES.include?(keyword) }
    validator for_keyword(1)

    def initialize(property, _, problem)
      @property = property
      @problem = problem
    end

    def remove
      "Remove #{@property} value (if it is present) from #{@problem} problem"
    end
  end
end
