# frozen_string_literal: true

require_relative 'actions/unknown_action'

module Commands
  # Mixin encapsulating the action handlers registry.
  module ActionHandler
    ACTIONS = Hash.new(UnknownAction.new)

    def register(handler)
      actions[handler.command] = handler.new
    end

    def actions
      ActionHandler::ACTIONS
    end
  end
end
