# frozen_string_literal: true

require 'byebug'
require 'yaml'
require 'artii'
require 'colored'
require 'terminal-table'

require_relative 'suite'
require_relative 'utils'

# Main class for commands integration testing
class CommandsTest
  SUITES_PATH = 'integration/suites'

  include Utils

  def initialize
    @suites = suites.map(&method(:load_suite))
  end

  def run
    print_banner('CLI Testing')
    run_suites
    collect_stats
    show_info
    exit_status
  end

  private

  def suites
    Dir.children(suites_path).map { |file| File.join(suites_path, file) }
  end

  def load_suite(suite)
    Suite.new(suite, YAML.load_file(suite))
  end

  def suites_path
    File.join(Dir.getwd, SUITES_PATH)
  end

  def run_suites
    @suites.each do |suite|
      suite.run!
      suite.print
    end
  end

  def collect_stats
    @total = @suites.sum(&:size)
    @failures = @suites.sum(&:failures)
    @successful = @total - @failures
  end

  def show_info
    labels = ["Suites found", "Successful executions", "Failures"]
    values = [@total, @successful, @failures]
    colors = %i[white green red]

    info = labels.zip(values, colors)
                 .map { |label, value, color| "#{label}: #{value.to_s.bold.send(color)}" }

    puts "\n"
    puts build_table([info], title: 'Summary')
  end

  def exit_status
    raise "Integration testing failed. See above for failure details" unless @failures.zero?
  end
end

CommandsTest.new.run
