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
    executed? ? print_tests : puts(pending_execution)
  end

  def size
    @executions.size
  end

  def successfuls
    @executions.count(&:success?)
  end

  def failures
    @executions.count { |execution| !execution.success? }
  end

  private

  def build_test(config)
    actions = fetch_as_array(config, 'action')
    args = fetch_as_array(config, 'args')
    name = config.fetch('name', actions.join(', '))
    expected = Expectations.determine_by(config['expects'])

    combinations = actions.product(args).map do |action, args_str|
      Execution.new(name, action, args_str, expected)
    end
  end

  def pending_execution
    single_cell_matrix('This suite has not been executed yet')
  end

  def print_tests
    results = @executions.map(&:result)
    puts build_table(results, headers: Execution::HEADERS, title: @name)
    puts "\n"
  end

  def fetch_as_array(config, property)
    value = config.fetch(property, [])
    value.is_a?(Array) ? value : [value]
  end
end
