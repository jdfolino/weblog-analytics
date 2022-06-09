# frozen_string_literal: true

class BaseFormatter
  def initialize(aggregator, sort_order)
    @aggregator = aggregator
    @sort_order = sort_order
  end

  def sorted_data
    uri_visit_data_aggregate = @aggregator.aggregate_data.values
    case @sort_order
    when 'unique-visits'
      uri_visit_data_aggregate.sort { |a, b| b.unique_visit_count <=> a.unique_visit_count }
    when 'visits'
      uri_visit_data_aggregate.sort { |a, b| b.visit_count <=> a.visit_count }
    end
  end
end
