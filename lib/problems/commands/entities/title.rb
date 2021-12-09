# frozen_string_literal: true

require_relative 'problem_property'

module Commands
  # Represents the title of a problem.
  class Title < ProblemProperty
    TITLE_KEYWORD = 'title'
    TITLE_VALID = /^[a-zA-Z0-9 _-]+$/.freeze

    validator args_size(4)
    validator keyword(TITLE_KEYWORD)
    validator valid_argument(TITLE_VALID)
    validator for_keyword

    def initialize(_, title, _, problem)
      @title = title
      @problem = problem
    end

    def edit
      "Edit title as #{@title} for #{@problem} problem"
    end
  end
end
