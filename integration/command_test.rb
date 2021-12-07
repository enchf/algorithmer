# frozen_string_literal: true

require 'problems/commands/entities/base'

class CommandTest
  HEADINGS = ['Test', 'CommandAction(s)', 'Expected', 'Status', 'Result'].freeze

  def initialize(config)
    @class_name = config['class']
    build_actions(config)
  end

  def run_and_print
    table = Terminal::Table.new title: class_name,
                                headings: HEADINGS,
                                rows: @actions.results
    puts table
  end

  private

  def build_actions(config)
    @actions = 
    
    
    
    []
    @actions << BatchTest.new(config['batch']) if config.key?('batch')
    config['actions'].each { |action_config| @actions << ActionTest.new(action_config) } if config.key?('actions')
  end
end
