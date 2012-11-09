# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yam/version'

Gem::Specification.new do |gem|
  gem.name          = "yam"
  gem.version       = Yam::VERSION
  gem.authors       = ["Mason Fischer"]
  gem.email         = ["mason@thoughtbot.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'hashie', '~> 1.2.0'
  gem.add_dependency 'faraday', '~> 0.8.1'
  gem.add_dependency 'faraday_middleware', '~> 0.9.0'
  gem.add_dependency 'multi_json', '~> 1.3'
  gem.add_dependency 'oauth2', '~> 0.8.0'
  gem.add_dependency 'rspec', '~> 2.11.0'
  gem.add_development_dependency 'simplecov', '~> 0.7.1'
  gem.add_development_dependency 'mocha', '~> 0.9.8'
  gem.add_development_dependency 'bourne', '~> 1.0'
  gem.add_development_dependency 'webmock', '~> 1.9.0'
end
