require './test/test_helper'
require './lib/helper_module'
require './lib/enigma'

class HelperMethodsTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_index_to_character
    assert_equal ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"], @enigma.index_to_character([11, 5, 4, 5, 18, 27, 15, 8, 21, 12, 23])
  end

  def test_index_text
    assert_equal [["h", 8],
 ["e", 5],
 ["l", 12],
 ["l", 12],
 ["o", 15],
 [" ", 27],
 ["w", 23],
 ["o", 15],
 ["r", 18],
 ["l", 12],
 ["d", 4]], @enigma.index_text("hello world")
  end

  def test_create_offset_digits
    @enigma.encrypt('hello world', "02715", "040895")
    assert_equal ["1", "0", "2", "5"], @enigma.create_offset_digits
  end

  def test_generate_offsets
    @enigma.encrypt('hello world', "02715", "040895")
    assert_equal ({:a=>3, :b=>0, :c=>19, :d=>20}), @enigma.generate_offsets
  end


end
