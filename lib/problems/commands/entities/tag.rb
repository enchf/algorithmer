# frozen_string_literal: true

require_relative 'problem_property'

module Commands
  # Represents a tag assigned to a problem.
  class Tag < ProblemProperty
    TAG_KEYWORD = 'tag'
    TAG_VALID = /^#[a-z]+$/.freeze

    validator args_size(4)
    validator keyword(TAG_KEYWORD)
    validator valid_argument(TAG_VALID)
    validator for_keyword

    def initialize(_, tag, _, problem)
      @tag = tag
      @problem = problem
    end

    def add
      "Add #{@tag} tag (if not already present) to #{@problem} problem"
    end
  end
end
