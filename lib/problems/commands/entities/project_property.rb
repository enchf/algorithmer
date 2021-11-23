# frozen_string_literal: true

require_relative 'base'

module Commands
  # Base entity class for objects related to a problem.
  class ProjectProperty < Base
    # TODO: Validates if the execution is within a project folder
    validator { |*_| true }
  end
end
