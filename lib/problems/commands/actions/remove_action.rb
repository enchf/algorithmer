# frozen_string_literal: true

require_relative 'action'

module Commands
  # Remove command configuration.
  class RemoveAction < Action
    subcommand 'remove'
  end
end
