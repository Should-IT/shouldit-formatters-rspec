$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'shouldit'

Gem::Specification.new do |s|
  s.name        = 'shouldit-formatters-rspec'
  s.version     = ShouldIT::Formatters::RSpecFormatter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Richard McIntyre', 'Luke Barratt']
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/should-it/shouldit-formatters-rspec'
  s.summary     = 'ShouldIT RSpec Formatter'
  s.description = 'Formats RSpec output as ShouldIT compatible JSON'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rspec-core', '~> 3.2'
  s.add_runtime_dependency 'rspec-expectations', '~> 3.2'

  s.add_development_dependency 'rake', '~> 10.4'
end
