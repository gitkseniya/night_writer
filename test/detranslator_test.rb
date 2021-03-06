require_relative 'test_helper'

class DetranslatorTest < Minitest::Test
  include Dictionary

  def setup
    @detranslator = Detranslator.new("0.00000.0..0
      ..0.0.0..00.
      ..0.0.0...0.")
  end

  def test_it_exists
    assert_instance_of Detranslator, @detranslator
  end

  def test_it_can_return_braille_to_eng_values
    assert_instance_of Hash, @detranslator.braille_to_eng
    assert_equal ["l"], @detranslator.braille_to_eng[["0.", "0.", "0."]]
  end

  def test_it_can_split_input
    expected = ["0.00000.0..0", "..0.0.0..00.", "..0.0.0...0."]

    assert_equal expected, @detranslator.split_input
  end

  def test_it_can_return_and_combine_every_fourth_line_with_first
    assert_equal "0.00000.0..0", @detranslator.mega_line(1)
  end

  def test_it_can_return_and_combine_every_fifth_line_with_second
    assert_equal "..0.0.0..00.", @detranslator.mega_line(2)
  end

  def test_it_can_return_and_combine_every_third_line
    assert_equal "..0.0.0...0.", @detranslator.mega_line(0)
  end

  def test_it_can_return_mega_first_line_as_a_nested_array
    expected = [["0", "."], ["0", "0"], ["0", "0"], ["0", "."], ["0", "."], [".", "0"]]

    assert_equal expected, @detranslator.mega_first_array
  end

  def test_it_can_return_mega_second_line_as_a_nested_array
    expected = [[".", "."], ["0", "."], ["0", "."], ["0", "."], [".", "0"], ["0", "."]]

    assert_equal expected, @detranslator.mega_second_array
  end

  def test_it_can_return_mega_third_line_as_a_nested_array
    expected = [[".", "."], ["0", "."], ["0", "."], ["0", "."], [".", "."], ["0", "."]]

    assert_equal expected, @detranslator.mega_third_array
  end

  def test_it_can_sort_nested_arrays_by_index
    expected = [["0", ".", ".", ".", ".", "."], ["0", "0", "0", ".", "0", "."], ["0", "0", "0", ".", "0", "."], ["0", ".", "0", ".", "0", "."], ["0", ".", ".", "0", ".", "."], [".", "0", "0", ".", "0", "."]]

    assert_equal expected, @detranslator.rearrangement_by_index
  end

  def test_it_can_combine_and_resplit_strings_to_match_dictionary_format
    expected = [["0.", "..", ".."], ["00", "0.", "0."], ["00", "0.", "0."], ["0.", "0.", "0."], ["0.", ".0", ".."], [".0", "0.", "0."]]

    assert_equal expected, @detranslator.make_it_readable
  end

  def test_it_can_do_magic_and_translate_braille_to_eng
    assert_equal "apples", @detranslator.eng_it
  end
end
