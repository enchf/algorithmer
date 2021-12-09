# frozen_string_literal: true

require_relative 'problem_property'
require_relative 'tag'
require_relative 'title'

module Commands
  # Represents a filter applied against the list of problems.
  class Filter < ProblemProperty
    BY_KEYWORD = 'by'
    SEARCH_TERM = valid_value(Title::TITLE_VALID)
    TAG_TERM = valid_value(Tag::TAG_VALID)

    validator not_empty_args
    validator keyword(BY_KEYWORD)
    validator do |_, *args| 
      args.all? do |argument|
        SEARCH_TERM.call(argument) || TAG_TERM.call(argument)
      end
    end

    def initialize(*filters)
      @filters = filters
    end

    def list
      "List the problems that meet the following filters: #{@filters.join(", ")}"
    end
  end
end
