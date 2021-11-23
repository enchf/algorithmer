# frozen_string_literal: true

require_relative 'problem_property'

module Commands
  # Represents a test case of a problem.
  class NumberedProperty < ProblemProperty
    def self.number(index = 1)
      proc { |*args| /^[0-9]+$/.match?(args[index]) }
    end
  end
end
