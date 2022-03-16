# frozen_string_literal: true

require 'problems/components/entity'
require 'problems/validation/validator_branch'

module Problems
  # Abstraction that represents a problem management & execution.
  class Problem < Entity
    PROBLEM_NAME = /^[A-Za-z0-9+_-]+$/.freeze

    def self.problem_exists?
      # TODO: Validate if problem exists in config
      proc { true }
    end

    #ValidatorBranch.import_predicates!(Problem, :problem_exists?)

    #ValidatorBranch.define_using_dsl!(:valid_problem?) do
    #  non_reserved_word
    #  format PROBLEM_NAME
    #  problem_exists?
    #end

    #action :add do
    #  all do
    #    non_reserved_word
    #    format PROBLEM_NAME
    #  end
    #end

    #action :run do #, :show, :remove do
    #  byebug
    #  problem_exists?
    #end

    action :add do #, :show, :remove do
      reserved_word :problem
    end

    #action :list do
    #  tail do
    #    all do
    #      non_reserved_word
    #      any do
    #        format QUOTED
    #        format WORD_FILTER
    #        format TAG
    #      end
    #    end
    #  end
    #end

    def add(problem)
      # TODO: Integrate parent entity - #{project.name}"
      "Problem #{problem} added to project"
    end

    def show(problem)
      "Show problem #{problem} details"
    end

    def remove(problem)
      "After confirmation, problem #{problem} is removed from project"
    end

    def run(problem)
      "All solutions for problem #{problem} executed against all test cases"
    end

    def list(*filters)
      "List all problems using the following filters: '#{filters.join(", ")}'"
    end
  end
end
