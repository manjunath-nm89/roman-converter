require 'test/unit'
require "debugger"
require File.expand_path('../../../../lib/roman_converter/roman_util.rb', __FILE__)
require File.expand_path('../../../../test/test_helper.rb', __FILE__)

class RomanConverter::RomanUtilTest < Test::Unit::TestCase

  def test_is_invalid_numerals
    roman_util = create_roman_util("MXVIMANJU")
    assert roman_util.is_invalid?
    assert roman_util.is_invalid_numerals?

    roman_util = create_roman_util("MXVI")
    assert_false roman_util.is_invalid_numerals?

    roman_util = create_roman_util("X")
    assert_false roman_util.is_invalid_numerals?

    roman_util = create_roman_util("AM")
    assert roman_util.is_invalid_numerals?
  end

  def test_is_repeating_succession
    roman_util = create_roman_util("MXVI")
    assert_false roman_util.is_repeating_succession?

    roman_util = create_roman_util("MMMCM")
    assert_false roman_util.is_repeating_succession?

    roman_util = create_roman_util("MMMMM")
    assert roman_util.is_repeating_succession?
    assert roman_util.is_invalid?

    roman_util = create_roman_util("MMMMCCCCC")
    assert roman_util.is_repeating_succession?
    assert roman_util.is_invalid?
  end

  def test_invalidate_never_repeatable_elements
    roman_util = create_roman_util("CD")
    assert_false roman_util.invalidate_never_repeatable_elements?

    roman_util = create_roman_util("DDD")
    assert roman_util.invalidate_never_repeatable_elements?
    assert roman_util.is_invalid?

    roman_util = create_roman_util("XLLL")
    assert roman_util.invalidate_never_repeatable_elements?    
    assert roman_util.is_invalid?
  end

  def test_invalidate_repeatable_elements_for_greater_than_max_occurrence
    roman_util = create_roman_util("CCCD")
    assert_false roman_util.invalidate_repeatable_elements?

    roman_util = create_roman_util("XXXIX")
    assert_false roman_util.invalidate_repeatable_elements?    

    roman_util = create_roman_util("CCCDCC")
    assert roman_util.invalidate_repeatable_elements?

    roman_util = create_roman_util("III")
    assert_false roman_util.invalidate_repeatable_elements?    

    roman_util = create_roman_util("IIII")
    assert roman_util.invalidate_repeatable_elements?
  end

  def test_invalidate_repeatable_elements_for_separated_by_a_single_small_value
    roman_util = create_roman_util("XXXIX")
    assert_false roman_util.invalidate_repeatable_elements?

    roman_util = create_roman_util("XXXIIX")
    assert roman_util.invalidate_repeatable_elements?

    roman_util = create_roman_util("XXXCX")
    assert roman_util.invalidate_repeatable_elements?
  end

  def test_invalidate_subtractable_elements_for_never_repeatable
    roman_util = create_roman_util("D")
    assert_false roman_util.invalidate_subtractable_elements?

    roman_util = create_roman_util("DI")
    assert_false roman_util.invalidate_subtractable_elements?

    roman_util = create_roman_util("ID")
    assert roman_util.invalidate_subtractable_elements?

    roman_util = create_roman_util("IV")
    assert_false roman_util.invalidate_subtractable_elements?

    roman_util = create_roman_util("IX")
    assert_false roman_util.invalidate_subtractable_elements?

    roman_util = create_roman_util("XL")
    assert_false roman_util.invalidate_subtractable_elements?

    roman_util = create_roman_util("XV")
    assert roman_util.invalidate_subtractable_elements?

    roman_util = create_roman_util("CD")
    assert_false roman_util.invalidate_subtractable_elements?

    roman_util = create_roman_util("CV")
    assert roman_util.invalidate_subtractable_elements?
  end
end