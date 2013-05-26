module RomanConverter
  class RomanUtil
    attr_reader :roman_array

    def initialize(roman_array)
      @roman_array = roman_array
    end

    # Converts the roman numerals into english mumber
    # => english number / false if invalid roman numeral combination
    def compute_number
      is_invalid? ? false : generate_number
    end


    # This method can be called directly on the roman_utils object provided the **roman_array** is valid?
    # Adds the values, if subtraction is required, then the iterator moves back and subtracts the value
    # => english number
    def generate_number
      number = 0
      @roman_number.each_with_index do |roman_number, array_index|
        current_element_value = RomanConverter::Rules::Mapper::VALUES[roman_number]
        number += current_element_value
        if array_index > 0 
          previous_element_value = RomanConverter::Rules::Mapper::VALUES[@roman_number[array_index - 1]]
          if previous_element_value < current_element_value
            # Here 2 is multiplied as the **previous_element_value** was previously added to the **number**
            number -= (previous_element_value * 2)
          end
        end
      end
    end

    def is_invalid?
      is_invalid_elements? ||
      is_repeating_succession? ||
      invalidate_never_repeatable_elements? ||
      invalidate_repeatable_elements? ||
      invalidate_subtractable_elements?
    end

    # Checks whether all the elements have proper roman numerals
    # => true / false
    def is_invalid_numerals?
      (@roman_array & RomanConverter::Rules::Mapper::VALUES.keys).size != 0
    end

    # Returns true if there is more than **MAX_SUCCESSIVE** successive elements
    # => true/false
    def is_repeating_succession?
      !generate_occurrence_list.find{|chunk| chunk.last > RomanConverter::Rules::MAX_SUCCESSIVE}.nil?
    end

    # Returns true if there are never repeatable elements occuring more than once
    # => true/false
    def invalidate_never_repeatable_elements?
      chunk_hash = generate_occurrence_hash
      RomanConverter::Rules::Mapper::NEVER_REPEATABLE.each do |roman_literal|
        return true if chunk_hash[roman_literal] > 1
      end
      return false
    end

    # Returns true if there are repeatable elements occuring more than **MAX_OCCURENCE**
    # Also, checks if there occurs repeatable elements occurring **MAX_OCCURENCE** times and respecting the condition
    # that it needs to be interleaved.
    # => true/false
    def invalidate_repeatable_elements?
      chunk_hash = generate_occurrence_hash
      chunk_list = generate_occurrence_list
      RomanConverter::Rules::Mapper::REPEATABLE.each do |roman_literal|
        if chunk_hash[roman_literal] > RomanConverter::Rules::MAX_OCCURENCE
          return true
        elsif chunk_hash[roman_literal] == Rules::MAX_OCCURENCE
          chunk_list_index = chunk_list.find_index{|chunk_array| chunk_array.first == roman_literal}
          next_index = chunk_list_index + 1
          return true if chunk_list[next_index].nil? || compare_mapper_values?(chunk_list[next_index].first, roman_literal)
        end
      end
      return false
    end

    # invalidates the subtraction rules
    # This method assumes that the **NEVER_REPEATABLE** elements occur only once.
    # Thus this method must be called after the **invalidate_never_repeatable_elements?** 
    # => true / false
    def invalidate_subtractable_elements?
      RomanConverter::Rules::Mapper::NEVER_REPEATABLE.each do |roman_literal|
        next_element = get_next_elements(roman_literal).first
        return true if !next_element.nil? && compare_mapper_values?(next_element, roman_literal, false)
      end
      RomanConverter::Rules::Mapper::SUBTRACTABLE_ELEMENTS.each do |roman_literal|
        next_elements = get_next_elements(roman_literal)
        next_elements.each do |next_element|
          return true if !next_element.nil? && !RomanConverter::Rules::Mapper::SUBTRACTABLE_ELIGIBLE[roman_literal].include?(next_element)
        end
      end
      return false
    end

  private

    def compare_mapper_values?(key1, key2, lesser = true)
      lesser ? mapper_value_less_than?(key1, key2) : mapper_value_greater_than?(key1, key2)
    end

    def mapper_value_greater_than?(key1, key2)
      RomanConverter::Rules::Mapper::VALUES[key1] > RomanConverter::Rules::Mapper::VALUES[key2]
    end

    def mapper_value_less_than?(key1, key2)
      RomanConverter::Rules::Mapper::VALUES[key1] < RomanConverter::Rules::Mapper::VALUES[key2]
    end
    
    # Returns the next elements of the matched elements with **roman_literal** in the array
    # => **@roman_array** = [1, 2, 3, 4, 5, 7, 1]   
    # => get_next_elements(1)
    # => [2, nil]
    # => get_next_elements(2)
    # => [3]
    def get_next_elements(roman_literal)
      index_map = @roman_array.map.with_index.to_a
      selected_array = index_map.select { |index_array| index_array.first == roman_literal }
      selected_array.collect{ |index_array| @roman_array[index_array.last + 1]}
    end

    # => generate_occurrence_hash([1,2,3,4,6,6,6,1,6])
    # => {1=>2, 2=>1, 3=>1, 4=>1, 6=>4}
    def generate_occurrence_hash
      occurrence_hash = {}
      generate_chunks do |category, chunk_array|
        num = occurrence_hash[category]
        occurrence_hash[category] = num.to_i + chunk_array.size
      end
      occurrence_hash
    end

    # => generate_occurrence_list([1,2,3,4,6,6,6,1,6])
    # => [[1, 1], [2, 1], [3, 1], [4, 1], [6, 3], [1, 1], [6, 1]]
    def generate_occurrence_list
      generate_chunks do |category, chunk_array|
        [category, chunk_array.size]
      end
    end

    # The method below categorises the successive elements and groups and returns based on the block
    # => generate_chunks([1,2,3,4,6,6,6]){|a, b| [a, b.size]}
    # => [[1, 1], [2, 1], [3, 1], [4, 1], [6, 3]]
    def generate_chunks(&block)
      @roman_array.chunk{|y| y}.map do |category, chunk_array|
        block.call(category, chunk_array)
      end
    end
  end
end