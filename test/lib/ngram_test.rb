require_relative '../test_helper'
require 'taxonomy'

class NgramTest < MiniTest::Unit::TestCase
  include Taxonomy
  def test_ngram
    result = Ngram.new("Debian is the best Linux operating system").ngrams
    expected = "debian", "is", "the", "best", "linux", "operating", "system", "debian is", "is the", "the best", "best linux", "linux operating", "operating system", "debian is the", "is the best", "the best linux", "best linux operating", "linux operating system"
    assert_equal expected, result
    result = Ngram.new("Debian is the best Linux operating system").ngrams(1..2)
    expected = ["debian", "is", "the", "best", "linux", "operating", "system", "debian is", "is the", "the best", "best linux", "linux operating", "operating system"]
    assert_equal expected, result
    result = Ngram.new("Debian is the best Linux operating system").ngrams(1)
    expected = ["debian", "is", "the", "best", "linux", "operating", "system"]
    assert_equal expected, result
  end
end
