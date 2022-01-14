# frozen_string_literal: true

require 'test_helper'
require 'problems/components/action'

class ActionBuilderTest < Minitest::Test
  OPERATIONS = %i[empty_args arguments explicit].freeze

  class Handler
    def action; end
  end

  def setup
    @builder = tested_class.new(Handler, :action)
  end

  private

  def tested_class
    Problems::Action::Builder
  end

  def apply_random_states(max = 5)
    OPERATIONS.zip(OPERATIONS.size.times.map { rand max })
              .flat_map { |operation, repeats| repeats.times.map { operation } }
              .shuffle
              .each { |operation| @builder.send(operation) }
  end
end
