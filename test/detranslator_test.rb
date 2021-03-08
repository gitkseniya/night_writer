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
    assert_equal "l", @detranslator.braille_to_eng[["0.", "0.", "0."]]
  end

  def test_it_can_split_input
    expected = ["0.00000.0..0", "..0.0.0..00.", "..0.0.0...0."]

    assert_equal expected, @detranslator.split_input
  end

  def test_it_can_return_and_combine_every_fourth_line_with_first
    assert_equal "0.00000.0..0", @detranslator.mega_first_line
  end

  def test_it_can_return_and_combine_every_fifth_line_with_second
    assert_equal "..0.0.0..00.", @detranslator.mega_second_line
  end
end
