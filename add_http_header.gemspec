# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'add_http_header/version'
Gem::Specification.new do |spec|
  spec.name          = 'add_http_header'
  spec.version       = AddHttpHeader::VERSION
  spec.authors       = ['Brian Durand', 'Milan Dobrota']
  spec.email         = ['mdobrota@tribpub.com']
  spec.summary       = 'Simple Rack middleware for adding HTTP header'
  spec.description   = 'Simple Rack middleware for adding custom HTTP headers.'
  spec.homepage      = ''

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 0'

  spec.add_development_dependency 'rspec', '>= 2.0.0'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
