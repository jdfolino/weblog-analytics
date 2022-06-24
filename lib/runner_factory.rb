# frozen_string_literal: true

require_relative 'aggregator_valid_only'
require_relative 'simple_aggregator'
require_relative 'app_logger'
require_relative 'runner'
require_relative './io/csv_parser'
require_relative './io/output/stdout_formatter'
require_relative './io/output/enhanced_stdout_formatter'

class RunnerFactory
  def self.build(options)
    AppLogger.info("Run with #{options}")
    aggregator = fetch_aggregator(options[:aggregator])
    formatter = fetch_formatter(options[:format]).new(aggregator, fetch_sorter(options[:sort_order]))
    csv_parser = CSVParser.new(options[:log_file])
    Runner.new(aggregator, formatter, csv_parser)
  end

  def self.fetch_sorter(name)
    {
      'unique-visits' => proc do |uri_visit_data_aggregate|
        uri_visit_data_aggregate.sort { |a, b| b.unique_visit_count <=> a.unique_visit_count }
      end,

      'visits' => proc do |uri_visit_data_aggregate|
        uri_visit_data_aggregate.sort { |a, b| b.visit_count <=> a.visit_count }
      end
    }[name]
  end

  def self.fetch_aggregator(name)
    {
      'valid-only' => AggregatorValidOnly,
      'simple' => SimpleAggregator
    }[name].new
  end

  def self.fetch_formatter(name)
    {
      'stdout' => StdoutFormatter,
      'enhanced' => EnhancedStdoutFormatter
    }[name]
  end
end
