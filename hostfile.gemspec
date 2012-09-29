# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hostfile/version'

Gem::Specification.new do |gem|
  gem.name          = "hostfile"
  gem.version       = Hostfile::VERSION
  gem.authors       = ["Isaac Wolkerstorfer"]
  gem.email         = ["i@agnoster.net"]
  gem.description   = %q{No-fuss hash-style hostfile manipulation}
  gem.summary       = %q{Hostfile lets you access your systems hosts file like a standard Ruby hash. It's built for simplicity, familiarity, and (as far as possible) atomicity.}
  gem.homepage      = "https://github.com/agnoster/hostfile.rb"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec", ">= 2.0.0"
end
