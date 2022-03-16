# frozen_string_literal: true

require 'toolcase'

module Problems
  # Generic validator
  class Validator
    attr_reader :reductor, :arguments, :children, :predicate

    def initialize(reductor, arguments, children, &predicate)
      @reductor = reductor
      @arguments = arguments
      @children = children.freeze
      @predicate = predicate
    end

    def valid?(*args)
      final_args = @arguments.call(*args)
      @predicate.call(*final_args) && children_valid?(*args)
    end

    def to_predicate
      proc { |*args| valid?(*args) }
    end

    def to_s(indent = 0)
      pad = '-' * indent
      head = "(#{@reductor})"
      data = "Arguments: #{print_proc(@arguments)}, Predicate: #{print_proc(@predicate)}"
      children = @children.map { |child| child.to_s(indent + 2) }.join("\n")

      "#{pad}[#{head} - #{data}]\n#{children}"
    end

    protected

    def children_valid?(*args)
      @children.empty? || @children.send(@reductor) { |child| child.valid?(*args) }
    end

    private

    def print_proc(proc)
      file, line = proc.source_location
      file = file.split("/").last
      "Source: #{file}, line #{line}"
    end
  end
end
