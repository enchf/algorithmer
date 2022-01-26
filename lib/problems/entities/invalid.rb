# frozen_string_literal: true

require 'problems/components/entity'

module Problems
  class Invalid < Entity
    def method_missing(method, *args)
      "Action '#{method}' is not defined for arguments: #{args.join(', ')}"
    end
  end
end
