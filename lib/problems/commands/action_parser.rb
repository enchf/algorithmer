# frozen_string_literal: true

require_relative 'action_handler'
require_relative 'actions/version_action'
require_relative 'actions/empty_action'

module Commands
  class ActionParser

    extend ActionHandler

    def self.resolve(action, args)
      actions[action].handle(action, args)
    end

    register VersionAction
    register EmptyAction
  end
end
