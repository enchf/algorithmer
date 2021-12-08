# frozen_string_literal: true

require_relative 'executable'
require_relative 'execution'
require_relative 'expectations'
require_relative 'utils'

class EntityTest
  ENTITIES_PATH = 'problems/commands/entities/'
  
  include Executable
  include Utils

  def initialize(clazz, actions)
    @class_name = clazz
    @tested_class = init_class
    @executions = build_actions(actions)
  end

  def run!
    execute! do
      @executions.each(&:run!)
      self.success = @executions.all?(&:success?)
    end
  end

  def print
    results = @executions.map(&:result)
    puts build_table(results, headers: Execution::HEADERS, title: "Tested class: #{@class_name}")
  end

  private

  def init_class
    filename = to_camelcase(@class_name)
    require ENTITIES_PATH + filename
    Object.const_get("::Commands::#{@class_name}")
  end

  def build_actions(configs)
    configs.flat_map do |config|
      actions = config.fetch('action', [])
      actions = [actions] unless actions.is_a?(Array)
      
      name = config.fetch('name', actions.join(', '))
      args = config.fetch('args', '')
      expected = Expectations.determine_by(config['expects'])

      actions.map { |action| Execution.new(name, action, args, expected) }
    end
  end
end
