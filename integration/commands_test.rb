# frozen_string_literal: true

require 'byebug'
require 'yaml'
require 'artii'
require 'colored'
require 'terminal-table'

require_relative 'suite'
require_relative 'utils'

class CommandsTest
  SUITES_PATH = 'integration/suites'

  include Utils

  def initialize
    @suites = suites.map(&method(:load_suite))
  end

  def run
    print_banner('CLI Testing')
    run_suites
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

  def show_info
    @successful = @suites.count(&:success?)

    labels = ["Suites found", "Successful executions", "Failures"]
    values = [@suites.size, @successful, @suites.size - @successful]
    colors = %i[white green red]

    info = labels.zip(values, colors)
                 .map { |label, value, color| "#{label}: #{value.to_s.bold.send(color)}" }

    puts build_table([info])
  end

  def exit_status
    fail "Integration testing failed. See above for failure details" unless @suites.size == @successful
  end
end

CommandsTest.new.run
