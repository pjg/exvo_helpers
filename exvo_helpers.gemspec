# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "exvo_helpers/version"

Gem::Specification.new do |gem|
  gem.name        = "exvo_helpers"
  gem.version     = Exvo::Helpers::VERSION
  gem.authors     = ["Paweł Gościcki"]
  gem.email       = ["pawel.goscicki@gmail.com"]
  gem.homepage    = "https://github.com/Exvo/exvo_helpers/"
  gem.summary     = %q{Collection of helper methods for various Exvo related apps/services}
  gem.description = %q{Ruby gem providing various helper methods, like auth_host, auth_uri, auth_require_ssl, cdn_host, etc.}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_development_dependency 'rspec', ['>= 2.8']
  gem.add_development_dependency 'guard', ['>= 0.10.0']
  gem.add_development_dependency 'guard-bundler'
  gem.add_development_dependency 'guard-rspec', ['>= 0.6.0']
  gem.add_development_dependency "rb-fsevent"
  gem.add_development_dependency "rb-inotify"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "simplecov-rcov"
end
