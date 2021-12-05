# frozen_string_literal: true

require_relative 'numbered_solution'

module Commands
  # Represents a solution of a problem.
  class NumberedSolutionForTest < NumberedSolution
    validator with_keyword(4)
    validator number(5)

    def initialize(_, index, _, problem, _, test_index)
      super(nil, index, nil, problem)
      @test = test_index
    end

    def run
      "Run solution ##{@index} for problem #{@problem} against #{@test} test case"
    end
  end
end
