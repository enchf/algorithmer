# frozen_string_literal: true

require_relative 'problem_property'

module Commands
  # Represents the title of a problem.
  class Title < ProblemProperty
    TITLE_KEYWORD = 'title'
    TITLE_VALID = /^'[a-zA-Z0-9 _-]+'$/.freeze

    validator args_size(4)
    validator keyword(TITLE_KEYWORD, 0)
    validator valid_argument(TITLE_VALID, 1)
    validator for_validator(2)

    def initialize(_, title, _, problem)
      @title = title
      @problem = problem
    end

    def edit
      "Edit title as #{@title} for #{@problem} problem"
    end
  end
end
