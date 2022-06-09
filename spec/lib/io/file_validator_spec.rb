# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/io/file_validator'

RSpec.describe FileValidator do
  describe 'validate!' do
    before do
      @fv = FileValidator.new('/does/not/exist.log')
      @fv.validate!
    end

    it 'adds an error' do
      expect(@fv.errors).to eq(['File: /does/not/exist.log does not exist'])
    end
  end

  describe 'valid_file?' do
    it 'returns true when the file exists' do
      fv = FileValidator.new("#{Dir.pwd}/spec/fixtures/one_site_one_ip_webserver.log")
      fv.validate!
      expect(fv.send(:valid_file?)).to eq(true)
    end

    it 'returns false when the file does not exist' do
      fv = FileValidator.new("#{Dir.pwd}/spec/fixtures/does_not_exist.log")
      fv.validate!
      expect(fv.send(:valid_file?)).to eq(false)
    end
  end

  describe 'valid_file_size?' do
    it 'returns true when the file size is under 20GB' do
      fv = FileValidator.new("#{Dir.pwd}/spec/fixtures/full_webserver_valid_ips.log")
      fv.validate!
      expect(fv.send(:valid_file_size?)).to eq(true)
    end

    it 'returns false when the file size is over 20GB' do
      fv = FileValidator.new("#{Dir.pwd}/spec/fixtures/full_webserver_valid_ips.log")
      allow(File).to receive(:size).and_return(FileValidator::MAX_FILESIZE + 1)
      fv.validate!
      expect(fv.send(:valid_file_size?)).to eq(false)
    end
  end
end
