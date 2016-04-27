# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'luminosity_contrast/version'

Gem::Specification.new do |spec|
  spec.name          = "luminosity_contrast"
  spec.version       = LuminosityContrast::VERSION
  spec.authors       = ["Justin Jones"]

  spec.summary       = %q{calculate Luminosity Contrast Ratio per WCAG 2.0 guideline 1.4}
  spec.homepage      = "https://github.com/devpuppy/luminosity_contrast"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
