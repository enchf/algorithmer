# frozen_string_literal: true

require_relative 'base'

module Commands
  # Represents a project, which is a set of problems and their properties.
  class Project < Base
    KEYWORD = 'project'
    NAME_VALID = /^[a-zA-Z0-9_-]+$/.freeze

    def initialize(_, name)
      @name = name
    end

    def init
      "A folder called #{@name} will be created to store problems"
    end

    def self.accept?(*args)
      keyword, name, *tail = args
      tail.empty? && keyword == KEYWORD && NAME_VALID.match?(name)
    end
  end
end
