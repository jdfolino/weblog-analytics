# frozen_string_literal: true

require 'json'
require 'logger'
require_relative 'file_validator'

class JSONParser
  def initialize(source)
    @source = source
    file_validator = ::FileValidator.new(@source)
    file_validator.validate!
    raise file_validator.errors unless file_validator.valid?
  end

  def run!(&block)
    # Processing line by line as we do not want to load the CSV into memory
    JSON.parse(@source, &block)
  end
end
