require './test/test_helper'
require './lib/enigma'

class TestEnigma < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_encrypt
    assert_equal ({ encryption: "keder ohulw",
      key: "02715",
      date: "040895" }), @enigma.encrypt('hello world', "02715", "040895")
    assert_equal 'keder ohulw', @enigma.encrypted_text
  end

  def test_decrypt
    assert_equal ({ decryption: "hello world",
      key: "02715",
      date: "040895" }), @enigma.decrypt("keder ohulw", "02715", "040895")
    assert_equal 'hello world', @enigma.message
  end

  def test_crack
    # assert_equal ({:encryption=>"vjqtbeaweqihssi",
    #    :key=>"08304",
    #    :date=>"291018"}), @enigma.encrypt("hello world end", "08304", "291018")
    # assert_equal 'hello world end', @enigma.message
    # assert_equal "vjqtbeaweqihssi", @enigma.encrypted_text
    #assert_equal 'hello world end', @enigma.message
    assert_equal ({:decryption=>"hello world end",
       :key=>"08304",
       :date=>"291018"}), @enigma.crack("vjqtbeaweqihssi", "291018")
  end

end
