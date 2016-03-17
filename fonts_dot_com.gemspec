# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fonts_dot_com/version'

Gem::Specification.new do |spec|
  spec.name          = "fonts_dot_com"
  spec.version       = FontsDotCom::VERSION
  spec.authors       = ["John Friel"]
  spec.email         = ["john@johnfriel.net"]

  spec.summary       = %q{For making requests to fonts.com API.}
  spec.description   = %q{Gem for making requests to fonts.com API.}
  spec.homepage      = "https://github.com/Postcontext/fonts_dot_com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
