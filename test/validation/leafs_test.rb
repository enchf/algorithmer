# frozen_string_literal: true

require 'test_helper'

require 'problems/validation/leafs'

class LeafsTest < Minitest::Test
  def test_registered_words
    words = %i[for goto loop]
    non_words = %i[global variable]

    words.each do |word|
      Problems::Leafs.reserved_word word
      assert Problems::Leafs::ReservedWords.include?(word)
    end
    non_words.each { |word| refute Problems::Leafs::ReservedWords.include?(word) }
  end
end
