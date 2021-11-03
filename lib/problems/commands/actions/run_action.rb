# frozen_string_literal: true

require_relative 'action'

module Commands
  # Run command configuration.
  class RunAction < Action
    subcommand 'run'
  end
end
