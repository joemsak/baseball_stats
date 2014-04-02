# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baseball_stats/version'

Gem::Specification.new do |spec|
  spec.name          = "baseball_stats"
  spec.version       = BaseballStats::VERSION
  spec.authors       = ["Joe Sak"]
  spec.email         = ["joe@joesak.com"]
  spec.summary       = %q{Report specific baseball statistics}
  spec.description   = %q{See summary}
  spec.homepage      = "http://github.com/joemsak/the-ol--ballgame"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4.0"

  spec.add_development_dependency "bundler",          "~> 1.5"
  spec.add_development_dependency "rake",             "~> 10.1"
  spec.add_development_dependency 'rspec',            "~> 2.14"
  spec.add_development_dependency 'cucumber',         "~> 1.3"
  spec.add_development_dependency 'database_cleaner', "~> 1.2"
end
