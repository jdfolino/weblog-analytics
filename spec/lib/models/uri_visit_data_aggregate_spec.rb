# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/models/uri_visit_data_aggregate'

RSpec.describe UriVisitDataAggregate do
  describe 'validate!' do
    before do
      @uvda = UriVisitDataAggregate.new('/home')
    end

    it 'calculates the average number of page views per page ' do
      @uvda.add('127.0.0.1')
      @uvda.add('127.0.0.1')
      @uvda.add('192.168.0.8')
      @uvda.add('192.168.0.8')
      @uvda.add('192.168.0.8')
      @uvda.add('192.168.0.8')
      expect(@uvda.average_views).to eq(3)
    end
  end
end
