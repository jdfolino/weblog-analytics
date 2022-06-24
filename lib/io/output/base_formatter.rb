# frozen_string_literal: true

class BaseFormatter
  def initialize(aggregator, sorter)
    @aggregator = aggregator
    @sorter = sorter
  end

  def sorted_data
    uri_visit_data_aggregate = @aggregator.aggregate_data.values
    @sorter.call(uri_visit_data_aggregate)
  end
end
