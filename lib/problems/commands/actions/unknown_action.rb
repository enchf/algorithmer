# frozen_string_literal: true

require_relative 'action'

module Commands
  # Handler for unknown actions.
  class UnknownAction < Action
    def handle(action, _)
      "Action not recognized: #{action}"
    end
  end
end
