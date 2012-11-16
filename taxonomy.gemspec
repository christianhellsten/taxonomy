# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'taxonomy'

Gem::Specification.new do |gem|
  gem.name          = "taxonomy"
  gem.version       = Taxonomy::VERSION
  gem.authors       = ["Christian Hellsten"]
  gem.email         = ["christian@aktagon.com"]
  gem.description   = %q{A simple Ruby library for extracting a taxonomy/dictionary from text}
  gem.summary       = %q{A simple Ruby library for extracting a taxonomy/dictionary from text}
  gem.homepage      = ""

  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-minitest"
  gem.add_development_dependency "rb-inotify"
  gem.add_development_dependency "pry"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
