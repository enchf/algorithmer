# frozen_string_literal: true

require 'problems/commands/entities/base'

class CommandTest
  HEADINGS = ['Test', 'CommandAction(s)', 'Expected', 'Status', 'Result'].freeze

  def initialize(config)
    @class_name = config['class']
    build_actions(config)
  end

  def run
  end

  private

  def build_actions(config)
  end
end
