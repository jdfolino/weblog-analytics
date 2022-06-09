# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/io/command_parser'

RSpec.describe CommandParser do
  describe 'parse' do
    it 'uses the first arg as the log file' do
      expect(described_class.parse(%w[webserver.log])[:log_file]).to eq('webserver.log')
    end

    describe 'options (long)' do
      before do
        @options = described_class.parse(%w[webserver.log --format stdout --aggregator simple])
      end

      it 'parses the format' do
        expect(@options[:format]).to eq('stdout')
      end

      it 'parses the aggregator' do
        expect(@options[:aggregator]).to eq('simple')
      end
    end

    describe 'options (short)' do
      before do
        @options = described_class.parse(%w[webserver.log -f stdout])
      end

      it 'parses the format' do
        expect(@options[:format]).to eq('stdout')
      end
    end
  end
end
