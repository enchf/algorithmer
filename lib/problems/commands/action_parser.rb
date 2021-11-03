# frozen_string_literal: true

require 'problems/common/registry_handler'

require_relative 'actions/unknown_action'
require_relative 'actions/version_action'
require_relative 'actions/empty_action'

require_relative 'actions/add_action'
require_relative 'actions/edit_action'
require_relative 'actions/init_action'
require_relative 'actions/list_action'
require_relative 'actions/remove_action'
require_relative 'actions/run_action'
require_relative 'actions/show_action'

module Commands
  # Action resolver.
  class ActionParser
    extend Common::RegistryHandler

    key(&:name)
    resolver { |action, args| actions[action].new.handle(action, args) }

    default UnknownAction

    # configs
    register VersionAction
    register EmptyAction
  end
end
