# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "exvo_helpers/version"

Gem::Specification.new do |s|
  s.name        = "exvo_helpers"
  s.version     = ExvoHelpers::VERSION
  s.authors     = ["Paweł Gościcki"]
  s.email       = ["pawel.goscicki@gmail.com"]
  s.homepage    = "https://github.com/Exvo/exvo_helpers/"
  s.summary     = %q{host/uri helper methods for various Exvo services}
  s.description = %q{Ruby gem providing helper *_uri/*_host methods for Exvo services/apps like DESKTOP/CFS/AUTH/THEMES.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', ['>= 2.8']
  s.add_development_dependency 'guard', ['>= 0.10.0']
  s.add_development_dependency 'guard-rspec', ['>= 0.6.0']
  s.add_development_dependency "rb-fsevent"
  s.add_development_dependency "rb-inotify"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "simplecov-rcov"
end
