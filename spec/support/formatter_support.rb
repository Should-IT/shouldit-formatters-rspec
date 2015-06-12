module FormatterSupport
  def reporter
    @reporter ||= setup_reporter
  end

  def config
    @configuration ||= begin
      RSpec::Core::Configuration.new.tap do |config|
        config.output_stream = formatter_output
      end
    end
  end

  def formatter
    @formatter ||= begin
      setup_reporter
      @formatter
    end
  end

  def setup_reporter
    config.add_formatter described_class
    @formatter = config.formatters.first
    @reporter = config.reporter
  end

  def setup_profiler
    config.profile_examples = true
    reporter.setup_profiler
  end

  def formatter_output
    @formatter_output ||= StringIO.new
  end
end
