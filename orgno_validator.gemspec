# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["André Bonkowski"]
  gem.email         = ["andre@kodemaker.no"]
  gem.description   = %q{Validate Norwegian "organisasjonsnummer"}
  gem.summary       = %q{Simple validator that validate Norwegian "organisasjonsnummer}
  gem.homepage      = "https://github.com/bonkowski/orgno_validator"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "orgno_validator"
  gem.require_paths = ["lib"]
  gem.version       = '0.0.1'
  gem.add_dependency("activemodel", ">= 0")
  gem.add_development_dependency("rspec", ">= 0")
end
