# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/runner_factory'
require_relative '../../lib/io/command_parser'

RSpec.describe RunnerFactory do
  before(:all) do
    options = CommandParser.parse(["#{Dir.pwd}/spec/fixtures/full_webserver_invalid_ips.log", '-a', 'simple'])
    @runner = described_class.build(options)
    @runner.run!
  end

  it 'retrieves the unique urls (validated)' do
    expect(@runner.aggregator.aggregate_data.keys.uniq.sort)
      .to eq(%w[/about /about/2 /contact /help_page/1 /home /index])
  end

  [
    { uri: '/help_page/1', expected_visit_count: 80, expected_unique_visit_count: 23 },
    { uri: '/contact', expected_visit_count: 89, expected_unique_visit_count: 23 },
    { uri: '/home', expected_visit_count: 78, expected_unique_visit_count: 23 },
    { uri: '/about/2', expected_visit_count: 90, expected_unique_visit_count: 22 },
    { uri: '/index', expected_visit_count: 82, expected_unique_visit_count: 23 },
    { uri: '/about', expected_visit_count: 81, expected_unique_visit_count: 21 }
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
