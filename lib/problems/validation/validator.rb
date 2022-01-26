# frozen_string_literal: true

require 'toolcase'

module Problems
  # Generic validator
  class Validator
    include Toolcase::Registry

    attr_accessor :predicate, :arguments, :reductor, :entity

    alias children registries
    alias add_child register

    def initialize(reductor:  Validator.default_reductor,
                   arguments: Validator.default_arguments,
                   entity: nil,
                   &predicate)
      @predicate = block_given? ? predicate : Validator.default_predicate
      @arguments = arguments
      @reductor = reductor
      @entity = entity
    end

    def valid?(*args)
      final_args = arguments.call(*args)
      valid_predicate = predicate.call(*final_args)
      valid_children = children.empty? || children.send(reductor) do |child|
        child.valid?(*args)
      end

      valid_predicate && valid_children
    end

    def evaluate(&block)
      tap { |it| it.instance_eval(&block) }
    end

    def config
      { reductor: reductor, arguments: arguments, entity: entity }
    end

    def self.default_reductor
      Validator.all
    end

    def self.default_arguments
      Validator.all_arguments
    end

    class << self
      # Reductors
      def any
        :any?
      end

      def all
        :all?
      end

      # Argument providers
      def all_arguments
        proc { |*args| args }
      end

      def indexed_argument(index)
        proc { |*args| [args[index]] }
      end

      def tail(start_index)
        proc { |*args| args.drop(start_index) }
      end

      # Predicates
      def default_predicate
        proc { |*_| true }
      end
    end
  end
end
