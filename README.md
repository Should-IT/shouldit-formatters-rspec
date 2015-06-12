# ShouldIT RSpec Formatter

Formats RSpec output as ShouldIT compatible JSON. Compatible with RSpec 3.2+

## Usage

Add `shouldit-formatter-rspec` to your Gemfile

    gem 'shouldit-formatters-rspec'

Configure RSpec to write results to a file

    require 'shouldit/formatters'

    RSpec.configure do |config|
      config.output_stream = File.open('spec/results.json', 'w')
      config.formatter = ShouldIT::Formatters::RSpecFormatter
    end

Configure ShouldIT to watch for changes in `shouldit.conf.json`

    {
      "results": "spec/results.json"
    }
