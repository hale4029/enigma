module HelperMethods

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
    original_text = text.downcase.chars
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

  def find_keys
    offset_digits = create_offset_digits
    key = {}
    key[:a] = ((@keys.chars[0] + @keys.chars[1]).to_i + offset_digits.shift.to_i) % 27
    key[:b] = ((@keys.chars[1] + @keys.chars[2]).to_i + offset_digits.shift.to_i) % 27
    key[:c] = ((@keys.chars[2] + @keys.chars[3]).to_i + offset_digits.shift.to_i) % 27
    key[:d] = ((@keys.chars[3] + @keys.chars[4]).to_i + offset_digits.shift.to_i) % 27
    key
  end

  def rand_keys
    (rand 00000..99999).to_s.rjust(5,'0')
  end

  def today_date
    Time.now.strftime("%d/%m/%y")
  end

end
