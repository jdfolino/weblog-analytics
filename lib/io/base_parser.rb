# frozen_string_literal: true

require_relative 'file_validator'

class BaseParser
  def initialize(source)
    @source = source
    file_validator = ::FileValidator.new(@source)
    file_validator.validate!
    raise file_validator.errors unless file_validator.valid?
  end

  def run!(_aggregator)
    raise 'Not implemented'
  end
end
