# frozen_string_literal: true

require_relative 'action'

module Commands
  # Edit command configuration.
  class EditAction < Action
    subcommand 'edit'
  end
end
