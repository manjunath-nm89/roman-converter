require 'test/unit'

def assert_false(boolean)
  assert !boolean
end

def create_roman_util(string)
  RomanConverter::RomanUtil.new(create_roman_array(string))
end

def create_roman_array(input_string)
  input_string.split("")
end