# frozen_string_literal: true

require_relative 'command_test'

class Suite
  def initialize(filename, config)
    @filepath = filename
    @filename = File.basename(@filepath)
    @name = config['name'] || @filename
    @tests = config.fetch('tests', []).map { |test_config| CommandTest.new(test_config) }
    
    @executed = false
    @success = nil
  end

  def run!
    @success = true
  end

  def print
    puts @name
  end

  def success?
    @success
  end
end
