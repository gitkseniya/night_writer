require_relative 'dictionary'

class Detranslator
  include Dictionary

  attr_reader :input_text

  def initialize(input_text)
    @input_text = input_text
  end

  def split_input
    input_text.split()
  end

  def mega_first_line
    split_input.select.with_index{|e,i| (i+1) % 3 == 1}.join
  end

  def mega_second_line
    split_input.select.with_index{|e,i| (i+1) % 3 == 2}.join
  end

  def mega_third_line
    split_input.select.with_index{|e,i| (i+1) % 3 == 0}.join
  end

  def mega_first_array
    mega_first_line.chars.each_slice(2).to_a
  end

  def mega_second_array
    mega_second_line.chars.each_slice(2).to_a
  end

  def mega_third_array
    mega_third_line.chars.each_slice(2).to_a
  end

  def rearrangement_by_index
    mega_first_array.map.with_index { |element,index| element + mega_second_array[index] + mega_third_array[index]}
  end

  def make_it_readable
    rearrangement_by_index.join.scan(/.{2}/).each_slice(3).to_a
  end

  def eng_it
    make_it_readable.map do |element|
      braille_to_eng.map do |braille, eng|
        if element == braille
          eng
        end
      end
    end.join
  end
end
