require_relative 'enigma'
enigma = Enigma.new
handle = File.open(ARGV[0], "r")
original_text = handle.read
enigma.encrypt(original_text)
writer = File.open(ARGV[1], "w")
writer.write(enigma.encoded_text)
puts "Created #{ARGV[1]} with the key #{enigma.keys} and date #{enigma.date}"
