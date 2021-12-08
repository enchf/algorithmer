# frozen_string_literal: true

require 'problems/commands/entities/base'
require_relative 'executable'

# Abstraction of a single command execution with arguments.
# Includes the validation of the expected result.
class Execution
  HEADERS = %w[Name Command Expected Result Status].freeze
  SUCCESS = '✓'.bold.green
  FAILURE = 'x'.bold.red
  SPLITTER = ".{1,%d}"
  DEFAULT_WIDTH = 22
  DEFAULT_ROWS = 5

  include Executable

  attr_reader :validator

  def initialize(name, action, args, expected)
    @name = name
    @action = action
    @args = args.split(' ')
    @validator = expected
    @execution_result = nil
  end

  def run!
    execute! do
      validator.valid? ? execute : handle_invalid
    end
  end

  def result
    [
      printable(@name), 
      printable(command), 
      printable(validator.expected), 
      printable(@execution_result), 
      status_mark
    ]
  end

  private

  def status_mark
    success? ? SUCCESS : FAILURE
  end

  def command
    "problems #{@action} #{@args.join(" ")}"
  end

  def handle_invalid
    @execution_result = 'Invalid test. Check configuration'
    self.success = false
  end

  def execute
    validate_action
    @execution_result = `#{command}`.strip
    self.success = validator.match?(@execution_result)
  rescue StandardError => e
    @execution_result = e.message
    self.success = false
  end

  def validate_action
    raise "Action #{@action} is invalid" unless ::Commands::Base::ACTIONS.include?(@action.to_sym)
  end

  def printable(string, width = DEFAULT_WIDTH, rows = DEFAULT_ROWS)
    string.scan(Regexp.new(SPLITTER % width)).take(rows).join("\n")
  end
end
