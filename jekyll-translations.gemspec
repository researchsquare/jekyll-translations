require 'jekyll/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-translations"
  spec.version       = Jekyll::Translations::VERSION
  spec.authors       = ["Research Square Company Engineering"]
  spec.email         = ["customer@researchsquare.com"]
  spec.require_paths = ["lib"]
  spec.summary       = %q{Translation tool for Jekyll}
  spec.homepage      = "https://github.com/researchsquare/jekyll-translations"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
end
