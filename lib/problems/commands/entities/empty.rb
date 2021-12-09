# frozen_string_literal: true

require_relative 'base'

module Commands
  # Represents emtpy argument list.
  # This is useful for general commands, like version or help.
  class Empty < Base
    validator empty

    def version
      Problems::VERSION
    end

    def list
      'List all problems'
    end

    def object_name
      'empty arguments'
    end
  end
end
