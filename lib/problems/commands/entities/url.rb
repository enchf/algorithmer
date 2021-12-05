# frozen_string_literal: true

require 'uri'
require_relative 'problem_property'

module Commands
  # Represents the URL of the problem.
  class Url < ProblemProperty
    URL_KEYWORD = 'url'
    URL_VALID = URI::DEFAULT_PARSER.make_regexp(%w[http https])

    validator args_size(4)
    validator keyword(URL_KEYWORD)
    validator valid_argument(URL_VALID)
    validator for_keyword

    def initialize(_, url, _, problem)
      @url = url
      @problem = problem
    end

    def edit
      "Edit URL as #{@url} for #{@problem} problem"
    end
  end
end
