require 'test/unit'
require "debugger"
require File.expand_path('../../../../lib/roman_converter/roman.rb', __FILE__)
require File.expand_path('../../../../test/test_helper.rb', __FILE__)

class RomanConverter::RomanTest < Test::Unit::TestCase
  def test_is_valid?
    roman = create_roman("XVI")
    assert_equal "XVI", roman.input
    assert_equal ["X", "V", "I"], roman.roman_array
    assert roman.is_valid?
    assert_equal 16, roman.convert_to_number

    roman = create_roman("XXVI")
    assert roman.is_valid?
    assert_equal 26, roman.convert_to_number

    roman = create_roman("VV")
    assert_false roman.is_valid?
    assert_false roman.convert_to_number
  end

  def test_convert_to_number
    roman = create_roman("D")
    assert_equal 500, roman.convert_to_number

    roman = create_roman("M")
    assert_equal 1000, roman.convert_to_number

    roman = create_roman("V")
    assert_equal 5, roman.convert_to_number

    roman = create_roman("IV")
    assert_equal 4, roman.convert_to_number

    roman = create_roman("XXXIX")
    assert_equal 39, roman.convert_to_number

    roman = create_roman("MCMXC")
    assert_equal 1990, roman.convert_to_number

    roman = create_roman("CV")
    assert_equal 105, roman.convert_to_number

    roman = create_roman("XV")
    assert_equal 15, roman.convert_to_number

    roman = create_roman("MMXIII")
    assert_equal 2013, roman.convert_to_number    

    roman = create_roman("XVI")
    assert_equal 16, roman.convert_to_number    

    roman = create_roman("MMXIIII")
    assert_false roman.convert_to_number    

    roman = create_roman("VC")
    assert_false roman.convert_to_number
  end
end