# frozen_string_literal: true

require_relative 'problem_property'
require_relative 'tag'
require_relative 'title'

module Commands
  # Represents a filter applied against the list of problems.
  class Filter < ProblemProperty
    FILTERS = [valid_value(Title::TITLE_VALID), valid_value(Tag::TAG_VALID)].freeze

    validator { |*args| args.empty? || args.any? { |filter| FILTERS.any?(filter) } }

    def initialize(*filters)
      @filters = filters.select { |filter| FILTERS.any?(filter) }
    end

    def list
      "List the problems that meet the following filters: #{@filters.join(", ")}"
    end
  end
end
