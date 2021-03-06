# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'binding_of_callers/version'

Gem::Specification.new do |spec|
  spec.name          = "binding_of_callers"
  spec.version       = BindingOfCallers::VERSION
  spec.authors       = ["ken"]
  spec.email         = ["block24block@gmail.com"]

  spec.summary       = %q{a wrapper of binding_of_caller, for easy use}
  spec.homepage      = 'https://github.com/turnon/binding_of_callers'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "binding_of_caller", "~> 1.0"
  spec.add_dependency "pry", ">= 0.10.0"
end
