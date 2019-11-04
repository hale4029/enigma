require './lib/enigma'
enigma = Enigma.new

path = "./text/" + ARGV[0]
handle = File.open(path, "r")
original_text = handle.read
original_text = original_text.strip
require "pry"; binding.pry
enigma.encrypt(original_text)
path_2 = "./text/" + ARGV[1]
writer = File.open(path_2, "w")
data = enigma.encoded_text
writer.write(data)
puts "Created #{ARGV[1]} with the key #{enigma.keys} and date #{enigma.date}"
