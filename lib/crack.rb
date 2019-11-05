require './lib/enigma'
enigma = Enigma.new

path = "./text/" + ARGV[0]
handle = File.open(path, "r")
encrypted_text = handle.read
encrypted_text = encrypted_text.strip
enigma.crack(encrypted_text, ARGV[2])
path_2 = "./text/" + ARGV[1]
writer = File.open(path_2, "w")
data = enigma.message
writer.write(data)
writer.close
puts "Created '#{ARGV[1]}' with the key #{enigma.keys} and date #{enigma.date}"
