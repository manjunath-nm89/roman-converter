# -*- encoding: utf-8 -*-
require File.expand_path('../lib/roman_converter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Manjunath Manohar"]
  gem.email         = ["manjunath.nm89@gmail.com"]
  gem.description   = "Roman Converter converts a roman numeral to an english / modern number. Making sure all rules invloved in the formation of a roman numeral is obeyed."
  gem.summary       = "Roman Converter converts a roman numeral to an english / modern number"
  gem.homepage      = "http://technical-arsenal.blogspot.in"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "roman_converter"
  gem.require_paths = ["lib"]
  gem.version       = RomanConverter::VERSION
  
  gem.add_development_dependency 'debugger'
end
