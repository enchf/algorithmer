# frozen_string_literal: true

require 'problems/components/entity'
require 'problems/validation/predicates'

module Problems
  # Abstraction that represents a problem management & execution.
  class Problem < Entity
    PROBLEM_NAME = /^[A-Za-z0-9+_-]+$/.freeze

    Predicates.update_dsl! do
      def problem_exists?(**config)
        Predicates.predicate_as_validator(**config) do |_|
          # TODO: Validate if problem exists in config
          true
        end
      end

      def valid_problem?(**config)
        Predicates.block_as_validator(**config) do
          non_reserved_word
          format PROBLEM_NAME
          problem_exists?
        end
      end
    end

    action :add do
      arguments do
        all do
          non_reserved_word
          format PROBLEM_NAME
        end
      end
    end

    action :run, :show, :remove do
      arguments do
        valid_problem?
      end
    end

    action :list do
      empty_args
    end

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
