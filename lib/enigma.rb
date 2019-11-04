require_relative './lib/helper_module'

class Enigma
  include HelperMethods

  attr_reader :keys, :date, :original_text
  attr_accessor :encoded_text

  def initialize
  end

  def encrypt(text, keys=rand_keys, date=today_date)
    @original_text = text
    @date = date.to_s
    @keys = keys.to_s
    @encoded_text = encode(text)
    {encryption: encoded_text, key: keys, date: date}
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
    @encoded_text = encrypted_text
    @original_text = decode(encrypted_text)
    {decryption: original_text, key: keys, date: date}
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
