# frozen_string_literal: true

require 'logger'

class AppLogger
  PROG_NAME = 'WebLogAnalyser'
  def self.instance
    # Create a Logger that prints to STDOUT
    @instance ||= Logger.new($stdout)
  end

  def self.debug(msg)
    instance.debug(PROG_NAME) { msg }
  end

  def self.info(msg)
    instance.info(PROG_NAME) { msg }
  end

  def self.warn(msg)
    instance.warn(PROG_NAME) { msg }
  end

  def self.error(msg)
    instance.error(PROG_NAME) { msg }
  end
end
