# frozen_string_literal: true

# Mixin for executable variables boilerplate.
module Executable
  def execute!
    yield if block_given?
    @executed = true
  end

  def executed?
    @executed
  end

  def success=(value = nil)
    @success = value
  end

  def success?
    defined?(@success) ? @success : false
  end
end
