# frozen_string_literal: true

require_relative 'project_property'

module Commands
  # Represents a problem within the project.
  class ProblemForTest < Problem
    validator with_keyword(1)
    validator number(2)

    def initialize(name, _, test_index)
      super(name)
      @test = test_index
    end

    def run
      "Run all solutions for problem #{@name} against #{@test} test case"
    end
  end
end
