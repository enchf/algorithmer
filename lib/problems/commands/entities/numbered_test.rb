# frozen_string_literal: true

require_relative 'numbered_property'
require_relative 'test'

module Commands
  # Represents a test case of a problem.
  class NumberedTest < NumberedProperty
    validator args_size(4)
    validator keyword(Test::TEST_KEYWORD)
    validator number
    validator for_keyword

    def initialize(_, index, _, problem)
      @index = index
      @problem = problem
    end

    def edit
      "Edit test case ##{@index} of problem #{@problem}"
    end

    def show
      "Show test case ##{@index} of problem #{@problem}"
    end

    def remove
      "Remove test case ##{@index} from problem #{@problem}"
    end
  end
end
