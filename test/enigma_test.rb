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
    assert_equal 'keder ohulw', @enigma.encrypt('hello world', '04/08/95', '02715')
  end

  def test_decode
  end

end
