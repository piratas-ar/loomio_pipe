# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loomio_pipe/version'

Gem::Specification.new do |spec|
  spec.name          = 'loomio_pipe'
  spec.version       = LoomioPipe::VERSION
  spec.authors       = ['Nicolás Reynolds', 'Partido Pirata de Argentina']
  spec.email         = ['fauno@partidopirata.com.ar', 'infraestructura@asambleas.partidopirata.com.ar']
  spec.summary       = %q{Loomio's reply by email via *nix pipe}
  spec.description   = %q{Loomio's reply by email via *nix pipe}
  spec.homepage      = 'http://github.com/piratas-ar/loomio-pipe'
  spec.license       = 'GPL-3.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty', '~> 0.13'
  spec.add_runtime_dependency 'mail',     '~> 2.6'
  spec.add_runtime_dependency 'json',     '~> 2.0'

  spec.add_development_dependency 'bundler',  '~> 1.7'
  spec.add_development_dependency 'rake',     '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.7'
  spec.add_development_dependency 'pry',      '~> 0.10'
end

