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

      def integrate!(target, &block)
        Leaves.singleton_methods.-([:integrate!]).each do |method|
          target.define_method(method) do |*args|
            predicate = Leaves.send(method, *args)
            instance_exec(predicate, &block)
          end
        end
      end
    end
  end
end
