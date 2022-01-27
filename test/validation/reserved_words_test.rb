# frozen_string_literal: true

require 'test_helper'
require 'problems/validation/predicates'
require 'problems/validation/reserved_words'

class ReservedWordsTest < Minitest::Test
  def test_registered_words
    words = %i[for goto loop]
    non_words = %i[global variable]

    words.each { |word| Problems::Predicates::EXECUTOR.reserved_word word }

    words.each { |word| assert Problems::ReservedWords.instance.include?(word) }
    non_words.each { |word| refute Problems::ReservedWords.instance.include?(word) }
  end
end
