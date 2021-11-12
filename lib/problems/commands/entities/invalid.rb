# frozen_string_literal: true

require_relative 'base'

module Commands
  # Represents invalid input.
  # It shows an error message in all actions.
  class Invalid < Base
    Base::ACTIONS.each do |action|
      define_method(action) do
        "Arguments passed do not represent a valid object: #{@args}"
      end
    end

    def initialize(*args)
      super(*args)
      @args = args
    end
  end
end
