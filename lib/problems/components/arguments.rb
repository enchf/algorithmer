# frozen_string_literal: true

require 'problems/validation/validator'

# An special case of a validator to bijectively assign a validator per input argument.
class Arguments < Validator
  def initialize(&block)

  end
end
