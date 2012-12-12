# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'yam/version'

Gem::Specification.new do |gem|
  gem.name          = 'yam'
  gem.version       = Yam::VERSION
  gem.authors       = ['Mason Fischer', 'Jessie A. Young']
  gem.email         = ['mason@thoughtbot.com', 'jessie@apprentice.io']
  gem.description   = %q{The official Yammer Ruby gem.}
  gem.summary       = %q{A Ruby wrapper for the Yammer REST API}
  gem.homepage      = %q{https://github.com/yammer/yam}

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'hashie', '~> 1.2.0'
  gem.add_dependency 'faraday', '~> 0.8.1'
  gem.add_dependency 'faraday_middleware', '~> 0.9.0'
  gem.add_dependency 'multi_json', '~> 1.3'
  gem.add_dependency 'oauth2', '~> 0.8.0'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov', '~> 0.7.1'
  gem.add_development_dependency 'mocha', '~> 0.9.8'
  gem.add_development_dependency 'bourne', '~> 1.0'
  gem.add_development_dependency 'webmock', '~> 1.9.0'
end
