# frozen_string_literal: true

require_relative 'base'

module Commands
  # Represents emtpy argument list.
  # This is useful for general commands, like version or help.
  class Empty < Base
    def self.accept?(*args)
      args.reject(&:nil?).reject(&:empty?).empty?
    end

    def version
      Problems::VERSION
    end
  end
end
