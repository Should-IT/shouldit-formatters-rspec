require 'spec_helper'
require 'support/formatter_support'
require 'shouldit'

RSpec.describe ShouldIT::Formatters::RSpecFormatter do
  include FormatterSupport

  let(:group_description) { 'ShouldIT Example Group' }

  let(:example_group) do
    RSpec.describe group_description do
      it 'Pass' do
        expect(true).to eq(true)
      end

      it 'Fail' do
        fail
      end

      it 'Pending'

      context 'Nested' do
        it 'Pass' do
          expect(false).to eq(false)
        end
      end
    end
  end

  before do
    reporter.report(example_group.examples.size) do |runner|
      example_group.run(runner)
    end
  end

  it 'Renders as JSON' do
    expect(JSON.parse(formatter_output.string)).to be_truthy
  end

  it 'Groups tests by descriptions' do
    expect(formatter.specs).to have_key(group_description)
  end

  it 'Groups tests by nested contexts' do
    expect(formatter.specs).to have_key("#{group_description} Nested")
  end

  it 'Contains the description and corresponding result' do
    group_output = formatter.specs[group_description]

    example_map = {
      'Pass' => 'PASSED',
      'Fail' => 'FAILED',
      'Pending' => 'PENDING'
    }

    example_map.each do |description, result|
      expect(group_output[description]).to eq(result)
    end
  end
end
