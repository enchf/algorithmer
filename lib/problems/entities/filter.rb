# frozen_string_literal: true

require 'problems/components/entity'

module Problems
  # Problem filtering.
  class Filter < Entity
    QUOTED = %r{^'[A-Za-z0-9/*.()\[\]{}+ _-]+'$}.freeze
    WORD_FILTER = %r{^[A-Za-z0-9/*.()\[\]{}+_-]+$}.freeze
    TAG = /^#[a-z]+$/.freeze

    action :list do
      arguments do
        reserved_word :by
        varargs do
          any do
            format QUOTED
            format WORD_FILTER
            format TAG
          end
        end
      end
    end

    def list(*filters)
      "List all problems using the following filters: '#{filters.join(",")}'"
    end
  end
end
