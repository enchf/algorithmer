# frozen_string_literal: true

require_relative 'problem_property'

module Commands
  # Represents a test case of a problem.
  class Test < ProblemProperty
    TEST_KEYWORD = 'test'

    validator args_size(3)
    validator keyword(TEST_KEYWORD)
    validator for_keyword(1)

    def initialize(_, _, problem)
      @problem = problem
    end

    def add
      "Add a test case to problem #{@problem}"
    end

    def list
      "List all test cases for problem #{@problem}"
    end
  end
end
