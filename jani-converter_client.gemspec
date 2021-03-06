# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jani/converter_client/version'

Gem::Specification.new do |spec|
  spec.name          = "jani-converter_client"
  spec.version       = Jani::ConverterClient::VERSION
  spec.authors       = ["Shin'ichi Ohno"]
  spec.email         = ["shin1ohno@me.com"]
  spec.summary       = %q{API client for jani-converter.}
  spec.description   = %q{API client for jani-converter.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "jani-from_json"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-collection_matchers"
end
