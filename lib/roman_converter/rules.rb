module RomanConverter
  module Rules
    MAX_SUCCESSIVE = 3
    MAX_OCCURENCE = 4    
    module Mapper
      VALUES = {
        "I" => 1,
        "V" => 5,
        "X" => 10,
        "L" => 50,
        "C" => 100,
        "D" => 500,
        "M" => 1000
      }

      REPEATABLE = ["I", "X", "C", "M"]
      NEVER_REPEATABLE = ["D", "L", "V"]

      SUBTRACTABLE_ELEMENTS = ["I", "X", "C"]
      SUBTRACTABLE_ELIGIBLE = {
        "I" => ["V", "X"],
        "X" => ["L", "C"],
        "C" => ["D", "M"]
      }
    end
  end
end