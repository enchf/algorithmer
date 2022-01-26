# frozen_string_literal: true

require 'problems/components/entity'

module Problems
  # Tool version handler.
  class Version < Entity
    action :version do
      empty_args
    end

    def version
      Problems::VERSION
    end
  end
end
