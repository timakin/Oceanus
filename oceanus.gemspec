# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oceanus/version'

Gem::Specification.new do |spec|
  spec.name          = "oceanus"
  spec.version       = Oceanus::VERSION
  spec.authors       = ["timakin"]
  spec.email         = ["timaki.st@gmail.com"]
  spec.summary       = "Oceanus: Docker implemented with Ruby"
  spec.description   = "Oceanus, docker implementation with Ruby, inspired by Bocker." 
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "thor"
end
