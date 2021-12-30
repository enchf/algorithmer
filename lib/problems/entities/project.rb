# frozen_string_literal: true

require_relative 'base'

module Commands
  # Represents a project, which is a set of problems and their properties.
  class Project < Base
    KEYWORD = 'project'
    NAME_VALID = /^[a-zA-Z0-9_-]+$/.freeze

    validator args_size(2)
    validator keyword(KEYWORD)
    validator valid_argument(NAME_VALID)

    def initialize(_, name)
      @name = name
    end

    def init
      "A folder called #{@name} will be created to store problems"
    end
  end
end
