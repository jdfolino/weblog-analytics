# frozen_string_literal: true

require 'csv'
require 'logger'
require_relative 'base_parser'
require_relative '../models/uri_visit_data'

class CSVParser < BaseParser
  def run!(aggregator)
    # Processing line by line as we do not want to load the CSV into memory
    CSV.foreach(@source, col_sep: ' ') do |row|
      url, ip_address = row
      AppLogger.debug("Processing: #{[url, ip_address].join(' ')}")
      uri_visit_data = UriVisitData.new(url, ip_address)
      uri_visit_data.validate!
      aggregator.add(uri_visit_data)
    end
  end
end
