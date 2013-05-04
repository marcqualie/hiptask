$:.unshift File.expand_path(File.dirname(__FILE__) + '/lib')
require 'hiptask/version'

Gem::Specification.new do |gem|

    gem.name          = "hiptask"
    gem.version       = Hiptask::VERSION
    gem.description   = "A simple command line tool for tracking your task list"
    gem.summary       = "Hipster tasks on the Command Line"
    
    gem.email         = "marc@marcqualie.com"
    gem.author        = "Marc Qualie"
    gem.homepage      = "https://github.com/marcqualie/hiptask"
    gem.license       = "MIT"

    gem.files         = `git ls-files`.split($/)
    gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
    gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
    gem.require_paths = ["lib"]

    gem.add_dependency "thor", "~> 0.18.1"

end
