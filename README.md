# RomanConverter

Roman Converter converts a roman numeral to an english / modern number. 

The gem checks for the validity of the roman numeral string, before converting.

## Installation

Add this line to your application's Gemfile:

    gem 'roman_converter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install roman_converter

## Usage
    
    The gem provides a method called `to_number`,  this converts the roman numeral string into number.
    But this is based on the validity of the Roman Numeral String.

    > require "roman_converter"
    => true
    > "MM".to_number
    => 2000
    > "VV".to_number
    => false
    > "manju".to_number
    => false
    > "XXXIX".to_number
    => 39

## Tests

    $ rake test    

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Please add tests for the feature which you have built
4. Commit your changes (`git commit -am 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
