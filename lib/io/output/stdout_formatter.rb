# frozen_string_literal: true

require_relative 'base_formatter'

class StdoutFormatter < BaseFormatter
  def display
    sorted_data.each do |uri_visit_data_aggregate|
      puts uri_visit_data_aggregate
    end
  end
end
