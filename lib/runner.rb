# frozen_string_literal: true

require_relative 'aggregator_valid_only'
require_relative 'simple_aggregator'
require_relative 'app_logger'
require_relative './io/csv_parser'
require_relative './io/output/stdout_formatter'

class Runner
  attr_reader :aggregator

  def initialize(options)
    AppLogger.info("Run with #{options}")
    @aggregator = fetch_aggregator(options[:aggregator])
    @formatter = fetch_formatter(options[:format]).new(@aggregator, options[:sort_order])
    @csv_parser = CSVParser.new(options[:log_file])
  end

  def run!
    @csv_parser.run!(@aggregator)
    @formatter.display
  end

  def fetch_aggregator(name)
    {
      'valid-only' => AggregatorValidOnly,
      'simple' => SimpleAggregator
    }[name].new
  end

  def fetch_formatter(name)
    {
      'stdout' => StdoutFormatter
    }[name]
  end
end
