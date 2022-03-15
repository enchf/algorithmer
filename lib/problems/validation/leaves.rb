# frozen_string_literal: true

require 'toolcase'

module Problems
  class Leaves
    class ReservedWords
      extend Toolcase::Registry
    end

    class << self
      def reserved_word(word)
        ReservedWords.register(word)
        proc { |value| value.to_s == word.to_s }
      end

      def non_reserved_word
        proc { |value| !ReservedWords.include?(value) }
      end

      def custom(&block)
        proc(&block)
      end

      def format(regex)
        proc { |value| regex.match?(value.to_s) }
      end

      def exportable_methods
        Leaves.singleton_methods - [:exportable_methods]
      end
    end
  end
end
