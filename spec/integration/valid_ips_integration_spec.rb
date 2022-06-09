# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/runner'
require_relative '../../lib/io/command_parser'

RSpec.describe Runner do
  before(:all) do
    @runner = described_class.new(CommandParser.parse(["#{Dir.pwd}/spec/fixtures/full_webserver_valid_ips.log", '-a',
                                                       'valid-only']))
    @runner.run!
  end

  it 'retrieves the unique urls (validated)' do
    expect(@runner.aggregator.aggregate_data.keys.uniq.sort)
      .to eq(%w[/about /about/2 /contact /help_page/1 /home /index])
  end

  [
    { uri: '/help_page/1', expected_visit_count: 7, expected_unique_visit_count: 5 },
    { uri: '/contact', expected_visit_count: 9, expected_unique_visit_count: 6 },
    { uri: '/home', expected_visit_count: 14, expected_unique_visit_count: 10 },
    { uri: '/about/2', expected_visit_count: 10, expected_unique_visit_count: 7 },
    { uri: '/index', expected_visit_count: 5, expected_unique_visit_count: 5 },
    { uri: '/about', expected_visit_count: 9, expected_unique_visit_count: 6 }
  ].each do |tc|
    it "counts the visits for #{tc[:uri]}" do
      expect(@runner.aggregator.aggregate_data[tc[:uri]].visit_count)
        .to eq(tc[:expected_visit_count])
    end

    it "counts the unique visits for #{tc[:url]}" do
      expect(@runner.aggregator.aggregate_data[tc[:uri]].unique_visit_count)
        .to eq(tc[:expected_unique_visit_count])
    end
  end
end
