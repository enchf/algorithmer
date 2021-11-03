# frozen_string_literal: true

require_relative 'version_action'

module Commands
  # Handler for the scenario of an empty action.
  # Currently displays the gem version.
  class EmptyAction < VersionAction
  end
end
