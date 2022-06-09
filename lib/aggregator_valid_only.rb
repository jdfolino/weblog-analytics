# frozen_string_literal: true

require_relative 'base_aggregator'
require_relative './models/uri_visit_data_aggregate'

class AggregatorValidOnly < BaseAggregator
  def add(uri_visit_data)
    uri_visit_data.validate!
    return unless uri_visit_data.valid?

    if @aggregate_data.key?(uri_visit_data.uri)
      @aggregate_data[uri_visit_data.uri].add(uri_visit_data.ip_address)
    else
      url_visit_data_aggregate = UriVisitDataAggregate.new(uri_visit_data.uri)
      url_visit_data_aggregate.add(uri_visit_data.ip_address)
      @aggregate_data[uri_visit_data.uri] = url_visit_data_aggregate
    end
  end
end
