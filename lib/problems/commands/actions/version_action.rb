# frozen_string_literal: true

require_relative 'action'

module Commands
  # Action that shows gem version.
  class VersionAction < Action
    subcommand '-v'

    def handle(*_)
      "problems version #{::Problems::VERSION}"
    end
  end
end
