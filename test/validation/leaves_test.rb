# frozen_string_literal: true

require 'test_helper'

require 'problems/validation/leaves'

class LeavesTest < Minitest::Test
  def test_registered_words
    words = %i[for goto loop]
    non_words = %i[global variable]

    words.each do |word|
      Problems::Leaves.reserved_word word
      assert Problems::Leaves::ReservedWords.include?(word)
    end
    non_words.each { |word| refute Problems::Leaves::ReservedWords.include?(word) }
  end
end
