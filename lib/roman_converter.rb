require File.expand_path('../roman_converter/roman.rb', __FILE__)
require File.expand_path('../roman_converter/roman_util.rb', __FILE__)
require File.expand_path('../roman_converter/rules.rb', __FILE__)

module RomanConverter

  String.class_eval do
    def to_number
      roman = RomanConverter::Roman.new(self)
      roman.convert_to_number
    end
  end

end
