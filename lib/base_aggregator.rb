# frozen_string_literal: true

class BaseAggregator
  attr_reader :aggregate_data

  def initialize
    @aggregate_data = {}
  end

  def add(_uri_visit_data)
    raise 'Not implemented'
  end
end
