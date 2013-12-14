# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lolbase/version"

Gem::Specification.new do |spec|
  spec.name          = "lolbase"
  spec.version       = LoLBase::VERSION
  spec.authors       = ["Regan Chan"]
  spec.email         = [""]
  spec.description   = %q{A basic Ruby wrapper for the League of Legends API.}
  spec.summary       = %q{A basic Ruby wrapper for the League of Legends API.}
  spec.homepage      = "https://github.com/Illianthe/lolbase"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "httparty"
end
