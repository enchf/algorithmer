# frozen_string_literal: true

require_relative 'execution'
require_relative 'executable'
require_relative 'expectations'
require_relative 'utils'

# Abstraction of a suite with multiple tests.
class Suite
  include Executable
  include Utils

  def initialize(filename, config)
    @filepath = filename
    @filename = File.basename(@filepath)
    @name = config['name'] || @filename
    @executions = config.fetch('tests', []).flat_map(&method(:build_test))
  end

  def run!
    execute! do
      @executions.each(&:run!)
      self.success = @executions.all?(&:success?)
    end
  end

  def print
    puts header
    executed? ? print_tests : puts(pending_execution)
  end

  private

  def build_test(config)
    actions = config.fetch('action', [])
    actions = [actions] unless actions.is_a?(Array)

    name = config.fetch('name', actions.join(', '))
    args = config.fetch('args', '')
    expected = Expectations.determine_by(config['expects'])

    actions.map { |action| Execution.new(name, action, args, expected) }
  end

  def header
    "\n\n#{single_cell_matrix(@name).bold}\n\n"
  end

  def pending_execution
    single_cell_matrix('This suite has not been executed yet')
  end

  def print_tests
    results = @executions.map(&:result)
    puts build_table(results, headers: Execution::HEADERS)
  end
end
