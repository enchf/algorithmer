# frozen_string_literal: true

require_relative 'base'

module Commands
  # Base entity class for objects related to a problem.
  class ProblemProperty < Base
    # TODO: Validates if a problem exists in the project
    def problem_exists?(_)
      true
    end

    # TODO: Validates if the execution is within a project folder
    def within_project_folder?
      true
    end

    def self.accept?(*_)
      within_project_folder? && problem_exists?
    end
  end
end
