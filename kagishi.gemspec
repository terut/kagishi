# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kagishi/version'

Gem::Specification.new do |spec|
  spec.name          = "kagishi"
  spec.version       = Kagishi::VERSION
  spec.authors       = ["terut"]
  spec.email         = ["terut.dev+github@gmail.com"]

  spec.summary       = %q{Handle token for magic link.}
  spec.description   = %q{Handle token for magic link.}
  spec.homepage      = "https://github.com/terut/kagishi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "jwt", "~> 1.5", ">= 1.5.4"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "timecop", "~> 0.8.1"
end
