# frozen_string_literal: true

require_relative 'entity_test'
require_relative 'executable'
require_relative 'utils'

# Abstraction of a suite with multiple tests.
class Suite
  include Executable
  include Utils

  def initialize(filename, config)
    @filepath = filename
    @filename = File.basename(@filepath)
    @name = config['name'] || @filename
    @tests = config.fetch('tests', []).map(&method(:build_test))
  end

  def run!
    execute! do
      @tests.each(&:run!)
      self.success = @tests.all?(&:success?)
    end
  end

  def print
    puts header
    executed? ? print_tests : puts(pending_execution)
  end

  private

  def build_test(config)
    ensure_present(config, 'class', @filename)
    ensure_present(config, 'actions', @filename)

    EntityTest.new(config['class'], config['actions'])
  end

  def header
    "#{single_cell_matrix(@name).bold}\n\n"
  end

  def pending_execution
    single_cell_matrix('This suite has not been executed yet')
  end

  def print_tests
    @tests.each(&:print)
  end
end
