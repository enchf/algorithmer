# frozen_string_literal: true

require_relative 'reserved_words'

module Problems
  class Leafs
    class << self
      def reserved_word(word)
        ReservedWords.publish(word)
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
        Leafs.singleton_methods.-([:integrate!]).each do |method|
          target.define_method(method) do |*args|
            predicate = Leafs.send(method, *args)
            block.call(predicate)
          end
        end
      end
    end
  end
end
