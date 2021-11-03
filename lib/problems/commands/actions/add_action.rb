# frozen_string_literal: true

require_relative 'action'

module Commands
  # Add command configuration.
  class AddAction < Action
    subcommand 'add'
  end
end
