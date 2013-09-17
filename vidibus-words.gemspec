# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'vidibus/words'

Gem::Specification.new do |s|
  s.name        = 'vidibus-words'
  s.version     = Vidibus::Words::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = 'Andre Pankratz'
  s.email       = 'andre@vidibus.com'
  s.homepage    = 'https://github.com/vidibus/vidibus-words'
  s.summary     = 'Tools for handling (stop-) words'
  s.description = 'Contains stop words lists and methods to extract keywords from strings.'
  s.license     = 'MIT'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'vidibus-words'

  s.add_dependency 'rails', '>= 3'
  s.add_dependency 'vidibus-core_extensions', '>= 0.4.1'

  s.add_development_dependency 'bundler', '>= 1.0.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rr'

  s.files = Dir.glob('{lib,app,config}/**/*') + %w[LICENSE README.md Rakefile]
  s.require_path = 'lib'
end
