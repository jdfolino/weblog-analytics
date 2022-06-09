# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/io/csv_parser'

class TestAggregator
  attr_reader :count

  def initialize
    @count = 0
  end

  def add(_)
    @count += 1
  end
end

RSpec.describe CSVParser do
  describe 'run!' do
    it 'processes every line' do
      csv_parser = CSVParser.new("#{Dir.pwd}/spec/fixtures/multiple_urls_multiple_ips_webserver.log")

      ta = TestAggregator.new
      csv_parser.run!(ta)
      expect(ta.count).to eq(4)
    end
  end
end
