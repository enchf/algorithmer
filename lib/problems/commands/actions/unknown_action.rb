# frozen_string_literal: true

module Commands
  # Handler for unknown actions.
  class UnknownAction
    def handle(action, _args)
      "Action not recognized: #{action}"
    end
  end
end
