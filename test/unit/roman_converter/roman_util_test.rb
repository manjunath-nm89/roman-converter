require 'test/unit'
require File.expand_path('../../../../lib/roman_converter/roman_util.rb', __FILE__)
require File.expand_path('../../../../test/test_helper.rb', __FILE__)

class RomanConverter::RomanUtilTest < Test::Unit::TestCase

  def test_is_invalid_numerals
    roman_util = RomanConverter::RomanUtil.new(create_roman_array("XMVIMANJU"))
    assert roman_util.is_invalid?
    assert roman_util.is_invalid_numerals?

    roman_util = RomanConverter::RomanUtil.new(create_roman_array("XMVI"))
    assert_false roman_util.is_invalid_numerals?

    roman_util = RomanConverter::RomanUtil.new(create_roman_array("X"))
    assert_false roman_util.is_invalid_numerals?

    roman_util = RomanConverter::RomanUtil.new(create_roman_array("AM"))
    assert roman_util.is_invalid_numerals?
  end

private
  
  def create_roman_array(string)
    string.split("")
  end 
end