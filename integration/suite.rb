# frozen_string_literal: true

require_relative 'entity_test'
require_relative 'utils'

class Suite
  include Utils

  def initialize(filename, config)
    @filepath = filename
    @filename = File.basename(@filepath)
    @name = config['name'] || @filename
    @tests = config.fetch('tests', []).map(&method(:build_test))
    
    @executed = false
    @success = nil
  end

  def run!
    @tests.each(&:run!)
    @success = @tests.all?(&:success?)
    @executed = true
  end

  def print
    puts header
    puts @executed ? tests_output : pending_execution
  end

  def success?
    @success
  end

  private

  def build_test(config)
    ensure_present(config, 'class', @filename)
    ensure_present(config, 'actions', @filename)

    EntityTest.new(config['class'], config['actions'])
  end

  def header
    single_cell_matrix(@name) + "\n\n"
  end

  def pending_execution
    single_cell_matrix('This suite has not been executed yet')
  end

  def tests_output
    @tests.each(&:print)
  end
end
