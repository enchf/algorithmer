# frozen_string_literal: true

require_relative 'action'

module Commands
  # List command configuration.
  class ListAction < Action
    subcommand 'list'
  end
end
