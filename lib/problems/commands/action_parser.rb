# frozen_string_literal: true

require 'problems/common/registry_handler'

require_relative 'actions/unknown_action'
require_relative 'actions/version_action'
require_relative 'actions/empty_action'

module Commands
  # Action resolver.
  class ActionParser
    extend Common::RegistryHandler

    def self.resolve(action, args)
      actions[action].new.handle(action, args)
    end

    default UnknownAction

    register VersionAction
    register EmptyAction
  end
end
