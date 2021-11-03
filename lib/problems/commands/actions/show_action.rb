# frozen_string_literal: true

require_relative 'action'

module Commands
  # Show command configuration.
  class ShowAction < Action
    subcommand 'show'
  end
end
