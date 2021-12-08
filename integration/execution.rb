# frozen_string_literal: true

require 'problems/commands/entities/base'
require_relative 'executable'

class Execution
  HEADERS = ['Name', 'Command', 'Expected', 'Result', 'Status'].freeze
  SUCCESS = '✓'.bold.green
  FAILURE = 'x'.bold.red
  SPLITTER = ".{1,%d}"
  DEFAULT_WIDTH = 30
  DEFAULT_ROWS = 5

  include Executable

  attr_reader :validator

  def initialize(clazz, name, action, args, expected)
    @tested_class = clazz
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
    [@name, command, printable(validator.expected), printable(@execution_result), status_mark]
  end

  private

  def status_mark
    success? ? SUCCESS : FAILURE
  end

  def command
    "#{@action} #{@args.join(' ')}"
  end

  def handle_invalid
    @execution_result = 'Invalid test. Check configuration'
    self.success = false
  end

  def execute
    validate_action
    instance = @tested_class.new(@args)
    @execution_result = instance.send(@action)
    self.success = validator.match?(@execution_result)
  rescue => ex
    @execution_result = ex.message
    self.success = false
  end

  def validate_action
    raise "Action #{@action} is invalid" unless ::Commands::Base::ACTIONS.include?(@action.to_sym)
  end

  def printable(string, width = DEFAULT_WIDTH, rows = DEFAULT_ROWS)
    string.scan(Regexp.new(SPLITTER % width)).take(rows).join("\n")
  end 
end
