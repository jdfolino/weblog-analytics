# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/aggregator_valid_only'
require_relative '../../lib/models/uri_visit_data'

RSpec.describe AggregatorValidOnly do
  let(:aggregator) { described_class.new }

  describe 'add' do
    it 'adds a new entry' do
      aggregator.add(UriVisitData.new('/home', '127.0.0.1'))
      expect(aggregator.aggregate_data.size).to eq(1)
    end

    it 'creates a new entry for a different url' do
      aggregator.add(UriVisitData.new('/home', '127.0.0.1'))
      aggregator.add(UriVisitData.new('/index', '127.0.0.1'))
      expect(aggregator.aggregate_data.size).to eq(2)
    end

    it 'counts the unique visits for each url' do
      aggregator.add(UriVisitData.new('/home', '127.0.0.1'))
      aggregator.add(UriVisitData.new('/home', '192.168.0.1'))
      aggregator.add(UriVisitData.new('/home/2', '192.168.0.1'))
      expect(aggregator.aggregate_data['/home'].unique_visit_count).to eq(2)
      expect(aggregator.aggregate_data['/home/2'].unique_visit_count).to eq(1)
    end
  end
end
