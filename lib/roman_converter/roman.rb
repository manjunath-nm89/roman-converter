require "rules.rb"
require "rule_util.rb"

module RomanConverter
  class Roman
    attr_reader :input, :roman_array

    def initialize(string)
      @input = string
      @roman_array = split_to_roman
    end

    def split_to_roman
      @input.split("")
    end

    def is_valid?
      rule_util = RuleUtil.new(@roman_array)
      !is_invalid?(rule_util)
    end

    def is_invalid?(rule_util)
      rule_util.is_invalid_elements? ||
      rule_util.is_repeating_succession? ||
      rule_util.invalidate_never_repeatable_elements? ||
      rule_util.invalidate_repeatable_elements? ||
      rule_util.invalidate_subtractable_elements?
    end
  end
end