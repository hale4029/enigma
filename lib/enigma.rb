require './lib/helper_module'
require './lib/crack_module'

class Enigma
  include HelperMethods
  include CrackMethods

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

  def decrypt(encrypted_message, keys=rand_keys, date=today_date)
    @date = date.to_s
    @keys = keys.to_s
    @encrypted_text = encrypted_message
    @message = decode(encrypted_message)
    {decryption: message, key: keys, date: date}
  end

  def decode(encrypted_message)
    indexed_chars = index_text(encrypted_message)
    rotate_offset = generate_offsets.values
    new_index_values = indexed_chars.reduce([]) do |acc, letter_index|
      acc << (letter_index[1] - rotate_offset[0] < 1 ? ((letter_index[1] - rotate_offset[0]) + 27) : (letter_index[1] - rotate_offset[0]))
      rotate_offset.rotate!
      acc
    end
    index_to_character(new_index_values).join
  end

  def crack(encrypted_message, date=today_date)
    @date = date.to_s
    @encrypted_text = encrypted_message
    @message = cracker(encrypted_message)
    {decryption: @message, key: @keys, date: @date}
  end

  def cracker(encrypted_message)
    indexed_chars = index_text(encrypted_message)
    # if indexed_chars.length % 4 == 3
    #   move = 1
    # elsif indexed_chars.length % 4 == 0
    #   move = 0
    # elsif indexed_chars.length % 4 == 1
    #   move = 3
    # else
    #   move = 2
    # end
    last_four_index = index_text(" end")
    last_four_chars = indexed_chars.last(4)
    @total_offset = last_four_chars.reduce([]) do |acc, letter_index|
      acc << ((letter_index[1] - last_four_index[0][1]) < 1 ? ((letter_index[1] + 27) - last_four_index[0][1] ) : (letter_index[1] - last_four_index[0][1]))
      last_four_index.rotate!
      acc.rotate(2)
    end

    @a = []; @b = [], @c = [], @d = []
    solve_for_key_offset
    possible_combinations
    key_iterations

    # @ending_cheat = last_four_chars.rotate(move).map { |x| x[0]}.join

    find_key
    decode(encrypted_message)
  end

end
