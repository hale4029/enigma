require './lib/helper_module'

class Enigma
  include HelperMethods

  attr_reader :keys, :date, :message
  attr_accessor :encrypted_text

  def initialize
  end

  def encrypt(text, keys=rand_keys, date=today_date)
    @message = text
    @date = date.to_s
    @keys = keys.to_s
    @encrypted_text = encode(text)
    {encryption: encrypted_text, key: keys, date: date}
  end

  def encode(text)
    indexed_chars = index_text(text)
    rotate_offset = generate_offsets.values
    new_index_values = indexed_chars.reduce([]) do |acc, letter_index|
      acc << (letter_index[1] + rotate_offset[0] > 27 ? ((letter_index[1] + rotate_offset[0]) - 27) : (letter_index[1] + rotate_offset[0]))
      rotate_offset.rotate!
      acc
    end
    index_to_character(new_index_values).join
  end

  def decrypt(encrypted_text, keys=rand_keys, date=today_date)
    @date = date.to_s
    @keys = keys.to_s
    @encrypted_text = encrypted_text
    @message = decode(encrypted_text)
    {decryption: message, key: keys, date: date}
  end

  def decode(encrypted_text)
    indexed_chars = index_text(encrypted_text)
    rotate_offset = generate_offsets.values
    new_index_values = indexed_chars.reduce([]) do |acc, letter_index|
      acc << (letter_index[1] - rotate_offset[0] < 1 ? ((letter_index[1] - rotate_offset[0]) + 27) : (letter_index[1] - rotate_offset[0]))
      rotate_offset.rotate!
      acc
    end
    index_to_character(new_index_values).join
  end


end
