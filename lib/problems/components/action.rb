# frozen_string_literal: true

require 'toolcase'
require 'problems/common/validator'
require 'problems/components/context'

module Problems
  # Abstraction of an executable action.
  class Action
    # Action generator through a builder pattern.
    class Builder
      def initialize(handler, action)
        @handler = handler
        @action = action
        @validations = Validator.new
        @passed_arguments = :all
        @context = nil
      end

      def empty_args
        reset do
          validations.add_child(Validator.new { |*args| args.empty? })
          passed_arguments = []
        end
      end

      def arguments(&block)
        reset do
          input = ArgumentsValidator.new
                                    .yield_self { |validator| validator.instance_eval(&block) }
                                    .children
          
          args = input.select(&:argument?).each_with_index
          context = Context.indexed(args.map { |arg, index| [index, arg.entity] }.to_h)
          passed_arguments = args.map(&:last)
          input.each_with_index
               .map { |validator, index| IndexedValidator.new(validator, index).with_context(context) }
               .each { |indexed_validator| validations.add_child(indexed_validator) }
        end
      end

      def explicit(validators)
        reset do
          passed_arguments = :all
          validators.each { |validator| validations.add_child(validator) }
        end
      end

      def build
        Action.new(handler, action, validations, argument_provider, context)
      end

      private

      attr_accessor :validations, :passed_arguments, :context

      def argument_provider
        return :itself.to_proc if passed_arguments == :all

        proc { |*args| passed_arguments.map { |index| args[index] } }
      end

      def reset(&block)
        validations.clear
        passed_arguments = :all
        context = nil
        yield_self { |it| it.instance_eval(&block) }
      end
    end

    def initialize(handler, action, validations, argument_provider, context
      @handler = handler
      @action = action
      @validations = validations
      @argument_provider = argument_provider
      @context = context
    end

    def execute(*args)
      handler.new.send(action, *argument_provider.call(*args)
    end

    def accept?(*args)
      validations.valid?(*args)
    end
  end
end
