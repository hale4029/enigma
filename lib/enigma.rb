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

  def crack(encrypted_text, date=today_date)
    @date = date.to_s
    @keys = keys.to_s
    @encrypted_text = encrypted_text
    @message = cracker(encrypted_text, date)
    {decryption: message, key: keys, date: date}
  end

  def cracker(encrypted_text, date)
    indexed_chars = index_text(encrypted_text)
    last_four_index = index_text(" end")
    last_four_chars = indexed_chars.last(4)
    total_offset = last_four_chars.reduce([]) do |acc, letter_index|
      acc << ((letter_index[1] - last_four_index[0][1]) < 1 ? ((letter_index[1] + 27) - last_four_index[0][1] ) : (letter_index[1] - last_four_index[0][1]))
      last_four_index.rotate!
      acc.rotate(2)
    end
    offset_digits = create_offset_digits
    number_set = (00..99).to_a
    a = []
    b = []
    c = []
    d = []
    number_set.map do |num|
      a << num if (((num + offset_digits[0].to_i) % 27) == total_offset[0])
      b << num if (((num + offset_digits[1].to_i) % 27) == total_offset[1])
      c << num if (((num + offset_digits[2].to_i) % 27) == total_offset[2])
      d << num if (((num + offset_digits[3].to_i) % 27) == total_offset[3])
    end
    possible_combinations = []
      a.each do |n1|
        b.each do |n2|
          c.each do |n3|
            d.each do |n4|
              possible_combinations.push([n1, n2, n3, n4])
            end
          end
        end
      end
    key_possibilities = possible_combinations.reduce([]) do |acc,key_iteration|
      acc << [key_iteration.join.rjust(8,"0").chars[0],
      key_iteration.join.rjust(8,"0").chars[1],
      key_iteration.join.rjust(8,"0").chars[3],
      key_iteration.join.rjust(8,"0").chars[5],
      key_iteration.join.rjust(8,"0").chars[7]].join
      acc
    end

    key_possibilities.find_all do |key_poss|
      decrypt(encrypted_text.chars.last(4).join, key_poss, date)
      " end" == @message
    end
      
  end

end
