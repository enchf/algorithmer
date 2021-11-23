# frozen_string_literal: true

require_relative 'project_property'

module Commands
  # Represents a problem within the project.
  class Problem < ProjectProperty
    NAME_VALID = /^[a-zA-Z0-9][a-zA-Z0-9_-]*$/.freeze

    validator args_size(1)
    validator valid_argument(NAME_VALID, 0)

    def initialize(name)
      @name = name
    end

    def add
      "A problem with id #{@name} will be added to the project"
    end

    def show
      "Show the details of problem #{@name}"
    end

    def remove
      "After asking for confirmation, problem #{@name} will be deleted"
    end
  end
end
