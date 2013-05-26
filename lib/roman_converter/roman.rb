require File.expand_path('../rules.rb', __FILE__)
require File.expand_path('../roman_util.rb', __FILE__)

module RomanConverter
  class Roman
    attr_reader :input, :roman_array
    attr_accessor :roman_util

    def initialize(string)
      @input = string
      @roman_array = @input.split("")
      @roman_util = RomanConverter::RomanUtil.new(@roman_array)
    end

    def is_valid?
      !@roman_util.is_invalid?
    end

    # Converts the roman numerals into english mumber
    # => english number / false if invalid roman numeral combination
    def convert_to_number
      @roman_util.compute_number
    end

  end
end