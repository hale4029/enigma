

class Enigma

  def initialize
  end

  def encrypt(text, date=today_date, keys=rand_keys)
    @original_text = text
    @encoded_text = encode(text)
    @date = date.to_s
    @keys = keys.to_s
  end

  def encode(text)
    alphabet = ('a'..'z').to_a << " "
    alphabet_hash = alphabet.map.with_index { |x, y| [x, y] }.to_h
    original_text = @original_text.downcase.chars
    step_2 = original_text.collect do |char|
      alphabet_hash.assoc(char)
    end

    require "pry"; binding.pry
    #
    # step_2.collect! do |x, y|
    #   if y < 30 && y >= @n
    #     y = y - @n
    #   elsif y < @n && y < 30
    #     y = 26 - (@n - y)
    #   else
    #     y = y
    #   end
    # end
    #
    # step_2.collect! do |char|
    #   alphabet.key(char)
    # end
    # step_2.join
  end

  def rand_keys
    rand 10000..99999
  end

  def today_date
    Time.now.strftime("%d/%m/%Y")
  end

end
