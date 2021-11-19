# frozen_string_literal: true

require_relative 'problem_property'

module Commands
  # Represents a tag assigned to a problem.
  class Tag < ProblemProperty
    TAG_KEYWORD = 'tag'
    FOR_KEYWORD = 'for'
    TAG_VALID = /^[a-z]+$/.freeze
    NAME_VALID = /^[a-zA-Z0-9][a-zA-Z0-9_-]*$/.freeze

    def initialize(_, tag, _, problem)
      @tag = tag
      @problem = problem
    end

    def add
      "Add #{@tag} tag (if not already present) to #{@problem} problem"
    end

    def remove
      "Remove tag #{@tag} (if not already present) from #{problem} problem"
    end

    def self.accept?(*args)
      keyword, tag, for_key, problem, *tail = args

      super && tail.empty? && keyword == KEYWORD && TAG_VALID.match?(tag) &&
        for_key == FOR_KEYWORD && NAME_VALID.match?(problem) && problem_exists?(problem)
    end
  end
end
