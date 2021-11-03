# frozen_string_literal: true

module Commands
  # Action that shows gem version.
  class VersionAction
    def handle(_action, _args)
      "problems version #{::Problems::VERSION}"
    end

    def self.key
      '-v'
    end
  end
end
