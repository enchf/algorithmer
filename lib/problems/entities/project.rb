# frozen_string_literal: true

require 'problems/components/entity'

module Problems
  # Abstraction of a Project containing problems and solutions.
  class Project < Entity
    PROJECT_NAME = /^[A-Za-z0-9_-]+$/.freeze

    action :init do
      arguments do
        reserved_word :project
        format PROJECT_NAME
      end
    end

    def init(name)
      "A folder called #{name} will be created to store problems"
    end
  end
end
