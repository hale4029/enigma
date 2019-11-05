require './lib/enigma'
enigma = Enigma.new

path = "./text/" + ARGV[0]
handle = File.open(path, "r")
message = handle.read
message = message.strip
enigma.encrypt(message, ARGV[2], ARGV[3])
path_2 = "./text/" + ARGV[1]
writer = File.open(path_2, "w")
data = enigma.encrypted_text
writer.write(data)
writer.close
puts "Created '#{ARGV[1]}' with the key #{enigma.keys} and date #{enigma.date}"
