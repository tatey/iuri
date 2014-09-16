# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iuri/version'

Gem::Specification.new do |spec|
  spec.name          = 'iuri'
  spec.version       = IURI::VERSION
  spec.authors       = ['Tate Johnson']
  spec.email         = ['tate@lifx.co']
  spec.summary       = %q{Build complex URIs with chainability and immutability.}
  spec.description   = %q{Build complex URIs with chainability and immutability.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end
