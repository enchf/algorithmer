# frozen_string_literal: true

require_relative 'problem_property'

module Commands
  # Represents a code solution of a problem.
  class Solution < ProblemProperty
    SOLUTION_KEYWORD = 'solution'

    validator args_size(3)
    validator keyword(SOLUTION_KEYWORD)
    validator for_keyword(1)

    def initialize(_, _, problem)
      @problem = problem
    end

    def add
      "Add a solution to problem #{@problem}"
    end

    def list
      "List all solutions for problem #{@problem}"
    end
  end
end
