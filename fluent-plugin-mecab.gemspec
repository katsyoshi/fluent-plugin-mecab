# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/mecab/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-mecab"
  spec.version       = Fluent::Plugin::Mecab::VERSION
  spec.authors       = ["MATSUMOTO Katsuyoshi"]
  spec.email         = ["github@katsyoshi.org"]
  spec.summary       = %q{fluentd plugin for MeCab}
  spec.description   = %q{fluentd plugin for MeCab}
  spec.homepage      = "http://github.com/katsyoshi/fluent-plugin-mecab"
  spec.license       = "Apache License, Version 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "fluentd"
  spec.add_dependency "natto"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
