# frozen_string_literal: true

require 'singleton'
require 'toolcase'

module Problems
  # Registry for reserved words used within the application
  class ReservedWords
    include Singleton
    include Toolcase::Registry
  end
end
