# frozen_string_literal: true

module Commands
  class UnknownAction
    def handle(action, _args)
      "Action not recognized: #{action}"
    end
  end
end
