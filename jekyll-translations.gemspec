Gem::Specification.new do |spec|
  spec.name          = "jekyll-translations"
  spec.version       = File.read(File.expand_path('../VERSION', __FILE__)).strip
  spec.authors       = ["Research Square Comapny Engineering"]
  spec.email         = ["customer@researchsquare.com"]
  spec.require_paths = ["lib"]
  spec.summary       = %q{Translation tool for Jekyll}
  spec.homepage      = "https://github.com/researchsquare/jekyll-translations"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
end
