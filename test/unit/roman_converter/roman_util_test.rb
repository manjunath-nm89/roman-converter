require 'test/unit'
require File.expand_path('../../../../lib/roman_converter/roman_util.rb', __FILE__)
require File.expand_path('../../../../test/test_helper.rb', __FILE__)

class RomanConverter::RomanUtilTest < Test::Unit::TestCase

  def test_is_invalid_numerals
    roman_util = RomanConverter::RomanUtil.new(create_roman_array("MXVIMANJU"))
    assert roman_util.is_invalid?
    assert roman_util.is_invalid_numerals?

    roman_util = RomanConverter::RomanUtil.new(create_roman_array("MXVI"))
    assert_false roman_util.is_invalid_numerals?

    roman_util = RomanConverter::RomanUtil.new(create_roman_array("X"))
    assert_false roman_util.is_invalid_numerals?

    roman_util = RomanConverter::RomanUtil.new(create_roman_array("AM"))
    assert roman_util.is_invalid_numerals?
  end

  def test_is_repeating_succession
    roman_util = RomanConverter::RomanUtil.new(create_roman_array("MXVI"))
    assert_false roman_util.is_repeating_succession?

    roman_util = RomanConverter::RomanUtil.new(create_roman_array("MMMCM"))
    assert_false roman_util.is_repeating_succession?

    roman_util = RomanConverter::RomanUtil.new(create_roman_array("MMMMM"))
    assert roman_util.is_repeating_succession?

    roman_util = RomanConverter::RomanUtil.new(create_roman_array("MMMMCCCCC"))
    assert roman_util.is_repeating_succession?
  end

private
  
  def create_roman_array(string)
    string.split("")
  end 
end