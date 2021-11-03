# frozen_string_literal: true

module Commands
  # Base class for all actions
  class Action
    def self.subcommand(val = nil)
      @subcommand ||= val unless val.nil?
      @subcommand if defined? @subcommand
    end

    def handle(action, args)
      "Command #{action} invoked with args: #{args}"
    end
  end
end
