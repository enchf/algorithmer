# frozen_string_literal: true

require_relative 'base'

module Commands
  # Represents a problem within the project.
  class Problem < Base
    NAME_VALID = /^[a-zA-Z0-9][a-zA-Z0-9_-]*$/.freeze

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

    def self.accept?(*args)
      name, *tail = args
      tail.empty? && NAME_VALID.match?(name)
    end
  end
end
