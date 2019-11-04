require_relative 'enigma'

enigma = Enigma.new
p enigma.encrypt("hello world end", "08304", "291018")
require "pry"; binding.pry
