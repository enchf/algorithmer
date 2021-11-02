# frozen_string_literal: true

module Commands
  class VersionAction
    def handle(_action, _args)
      return "problems version #{::Problems::VERSION}"
    end

    def self.command
      '-v'
    end
  end
end
