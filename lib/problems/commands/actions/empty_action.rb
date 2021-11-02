# frozen_string_literal: true

module Commands
  # Handler for the scenario of an empty action.
  # Currently displays the gem version.
  class EmptyAction < VersionAction
    def self.command
      nil
    end
  end
end
