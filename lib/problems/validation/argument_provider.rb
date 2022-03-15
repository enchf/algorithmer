# frozen_string_literal: true

module Problems
  # Pre-defined blocks to specify arguments to validators.
  class ArgumentProvider
    class << self
      def all
        proc { |*args| args }
      end

      def by_index(index)
        proc { |*args| args[index] }
      end

      def tail(from)
        proc { |*args| args[from..] }
      end

      def slice(from, to)
        proc { |*args| args[from..to] }
      end

      def empty
        proc { |*args| [] }
      end
    end
  end
end
