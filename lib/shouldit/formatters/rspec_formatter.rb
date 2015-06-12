require 'rspec/core'
require 'rspec/core/formatters/base_formatter'
require 'json'

module ShouldIT
  module Formatters
    class RSpecFormatter < ::RSpec::Core::Formatters::BaseFormatter
      VERSION = '0.0.1'

      ::RSpec::Core::Formatters.register self, :stop, :close

      attr_reader :output, :specs

      def initialize(output)
        super

        @specs = {}
      end

      def stop(notification)
        examples = notification.examples.map do |example|
          map_example(example)
        end

        build_output(examples)
      end

      def map_example(example)
        {
          group: group_for(example.metadata),
          description: example.metadata[:description],
          result: result_for(example.metadata)
        }
      end

      def group_for(metadata)
        metadata[:full_description].gsub(metadata[:description], '').strip
      end

      def result_for(metadata)
        metadata[:execution_result].status.upcase.to_s
      end

      def build_output(examples)
        examples.each do |example|
          group = @specs[example[:group]] || {}

          @specs[example[:group]] = group.merge({
            example[:description] => example[:result]
          })
        end
      end

      def close(_notification)
        output.write @specs.to_json
        output.close if IO === output && output != $stdout
      end
    end
  end
end
