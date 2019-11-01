

class Enigma

  def initialize
  end

  def encrypt(text, date=(Time.now.strftime("%d/%m/%Y")), keys=(rand 10000..99999))
    @original_text = encrypt_helper(text)
    @date = date.to_s
    @keys = keys.to_s
  end

  def encrypt_helper(text)
    
  end

end
