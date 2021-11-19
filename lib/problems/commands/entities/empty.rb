# frozen_string_literal: true

require_relative 'base'

module Commands
  # Represents emtpy argument list.
  # This is useful for general commands, like version or help.
  class Empty < Base
    validator { |*args| args.reject(&:nil?).reject(&:empty?).empty? }

    def version
      Problems::VERSION
    end

    def object_name
      'empty arguments'
    end
  end
end
