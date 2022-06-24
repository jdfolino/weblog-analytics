# frozen_string_literal: true

require_relative 'base_formatter'

class EnhancedStdoutFormatter < BaseFormatter
  def display
    sorted_data.each do |uri_visit_data_aggregate|
      puts print_with_average(uri_visit_data_aggregate)
    end
  end

  private

  def print_with_average(uri_visit_data_aggregate)
    "#{uri_visit_data_aggregate}, average: #{uri_visit_data_aggregate.average_views}"
  end
end
