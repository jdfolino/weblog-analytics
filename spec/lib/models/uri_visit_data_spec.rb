# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/models/uri_visit_data'

RSpec.describe UriVisitData do
  describe 'validate!' do
    before do
      @uvd = UriVisitData.new('  mal formed', '111.444.333.888')
      @uvd.validate!
    end

    it 'adds an error' do
      expect(@uvd.errors).to eq(['111.444.333.888 is invalid IP Address', '  mal formed is invalid URI'])
    end
  end
end
