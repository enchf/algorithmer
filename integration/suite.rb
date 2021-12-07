# frozen_string_literal: true

require_relative 'command_test'

class Suite
  def initialize(config)
    
    @name = config['name']
    @tests = config['tests'].map { |test_config| CommandTest.new(test_config) }
  end

  def test
    puts "*** Running suite: #{@name.bold} ***"
    @tests.each(&:run_and_print)
  end
end
