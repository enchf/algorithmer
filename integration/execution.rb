# frozen_string_literal: true

require_relative 'executable'

class Execution
  HEADERS = ['Name', 'Command', 'Expected', 'Result', 'Status'].freeze
  SUCCESS = '✓'.bold.green
  FAILURE = 'x'.bold.red

  include Executable

  attr_reader :validator

  def initialize(name, action, args, expected)
    @name = name
    @action = action
    @args = args.split(' ')
    @validator = expected
  end

  def run!
    execute! do
      self.success = true
    end
  end

  def result
    [@name, command, validator.expected, 'Value'.bold, status_mark]
  end

  private

  def status_mark
    success? ? SUCCESS : FAILURE
  end

  def command
    "#{@action} #{@args.join(' ')}"
  end
end
