
module CrackMethods

  def solve_for_key_offset
    offset_digits = create_offset_digits
    number_set = (00..99).to_a
    number_set.map do |num|
      a << num.to_s.rjust(2,'0') if (((num + offset_digits[0].to_i) % 27) == total_offset[0])
      b << num.to_s.rjust(2,'0') if (((num + offset_digits[1].to_i) % 27) == total_offset[1])
      c << num.to_s.rjust(2,'0') if (((num + offset_digits[2].to_i) % 27) == total_offset[2])
      d << num.to_s.rjust(2,'0') if (((num + offset_digits[3].to_i) % 27) == total_offset[3])
    end
  end


  def possible_combinations
    combinations = []
      a.each do |n1|
        b.each do |n2|
          c.each do |n3|
            d.each do |n4|
              combinations.push([n1, n2, n3, n4])
            end
          end
        end
      end
  end

end
