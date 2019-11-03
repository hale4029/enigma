class Enigma
  attr_reader :keys, :date, :original_text
  attr_accessor :encoded_text

  def initialize
  end

  def encrypt(text, date=today_date, keys=rand_keys)
    @original_text = text
    @date = date.to_s
    @keys = keys.to_s
    @encoded_text = encode(text)
  end

  def encode(text)
    array = index_text(text)
    offset = generate_offsets.values
    rotate_offset = offset
    new_index_values = array.reduce([]) do |acc, letter_index|
      acc << (letter_index[1] + rotate_offset[0] > 27 ? ((letter_index[1] + rotate_offset[0]) - 27) : (letter_index[1] + rotate_offset[0]))
      rotate_offset = rotate_offset.rotate
      acc
    end
    index_to_character(new_index_values).join
  end

  def index_to_character(index_values)
    alphabet = ('a'..'z').to_a << " "
    alphabet_hash = alphabet.map.with_index(1) { |x, y| [x, y] }.to_h
    index_values.map do |index|
      alphabet_hash.key(index)
    end
  end

  def index_text(text)
    alphabet = ('a'..'z').to_a << " "
    alphabet_hash = alphabet.map.with_index(1) { |x, y| [x, y] }.to_h
    original_text = @original_text.downcase.chars
    original_text.collect do |char|
      alphabet_hash.assoc(char)
    end
  end

  def create_offset_digits
    (@date.delete('/').to_i ** 2).to_s.chars.last(4)
  end

  def generate_offsets
    offset_digits = create_offset_digits
    offset = {}
    offset[:a] = ((@keys.chars[0] + @keys.chars[1]).to_i + offset_digits.shift.to_i) % 27
    offset[:b] = ((@keys.chars[1] + @keys.chars[2]).to_i + offset_digits.shift.to_i) % 27
    offset[:c] = ((@keys.chars[2] + @keys.chars[3]).to_i + offset_digits.shift.to_i) % 27
    offset[:d] = ((@keys.chars[3] + @keys.chars[4]).to_i + offset_digits.shift.to_i) % 27
    offset
  end

  def rand_keys
    rand 10000..99999
  end

  def today_date
    Time.now.strftime("%d/%m/%y")
  end

end
