# frozen_string_literal: true

class Runner
  attr_reader :aggregator

  def initialize(aggregator, formatter, csv_parser)
    @aggregator = aggregator
    @formatter = formatter
    @csv_parser = csv_parser
  end

  def run!
    @csv_parser.run!(@aggregator)
    @formatter.display
  end
end
