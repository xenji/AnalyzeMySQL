# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'AnalyzeMySQL/version'

Gem::Specification.new do |spec|
  spec.name          = 'AnalyzeMySQL'
  spec.version       = AnalyzeMySQL::VERSION
  spec.authors       = ['Mario Mueller']
  spec.email         = %w(mario@xenji.com)
  spec.description   = %q{AnalyzeMySQL comes from the need to get a detailed analysis of a bigger MySQL database.}
  spec.summary       = %q{AnalyzeMySQL is an extensible framework for MySQL schema analysis.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'mysql2'
  spec.add_development_dependency 'colorize'
  spec.add_development_dependency 'activesupport', '~> 3.2'

end
