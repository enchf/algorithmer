# frozen_string_literal: true

require 'problems/components/entity'

module Problems
  # Invalid usage of any entity.
  class Invalid < Entity
    def method_missing(method, *args)
      "Action '#{method}' is not defined for arguments: #{args.join(", ")}"
    end

    def respond_to_missing?(_, _ = false)
      false
    end
  end
end
