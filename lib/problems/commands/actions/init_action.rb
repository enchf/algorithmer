# frozen_string_literal: true

require_relative 'action'

module Commands
  # Init command configuration.
  class InitAction < Action
    subcommand 'init'
  end
end
