# frozen_string_literal: true

class FileValidator
  MAX_FILESIZE = 21_474_836_480 # 20GB
  attr_reader :errors

  def initialize(filename)
    @filename = filename
    @errors = []
  end

  def valid?
    @errors.empty?
  end

  def validate!
    if valid_file?
      @errors << "File: #{@filename} must be less than 20GB" unless valid_file_size?
    else
      @errors << "File: #{@filename} does not exist"
    end
  end

  private

  def valid_file?
    @valid_file ||= File.file?(@filename)
  end

  def valid_file_size?
    File.size(@filename) < MAX_FILESIZE
  end
end
