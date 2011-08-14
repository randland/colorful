# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "colorful/version"

Gem::Specification.new do |s|
  s.name        = "colorful"
  s.version     = Colorful::VERSION
  s.authors     = ["Nick Karpenske"]
  s.email       = ["randland@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Terminal Color Gem}
  s.description = %q{Provides string extensions for terminal color output}

  s.rubyforge_project = "colorful"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "fuubar"
  # s.add_runtime_dependency "rest-client"
end
