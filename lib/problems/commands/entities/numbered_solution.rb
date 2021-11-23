# frozen_string_literal: true

require_relative 'numbered_property'
require_relative 'solution'

module Commands
  # Represents a solution of a problem.
  class NumberedSolution < NumberedProperty
    validator args_size(4)
    validator keyword(Solution::SOLUTION_KEYWORD)
    validator number
    validator for_keyword

    def initialize(_, index, _, problem)
      @index = index
      @problem = problem
    end

    def edit
      "Edit solution ##{@index} of problem #{@problem}"
    end

    def show
      "Show solution ##{@index} of problem #{@problem}"
    end

    def remove
      "Remove solution ##{@index} from problem #{@problem}"
    end
  end
end
