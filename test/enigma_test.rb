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
    assert_equal [], @enigma.encrypt("hello world")
  end

  
end
