require_relative 'enigma'

enigma = Enigma.new
enigma.encrypt('hello world', "02715", "040895")
require "pry"; binding.pry
