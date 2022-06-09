#!/usr/local/bin/ruby
# frozen_string_literal: true

require_relative 'lib/runner'
require_relative 'lib/io/command_parser'
AppLogger.instance.level = ENV['LOG_LEVEL'] || 3
options = CommandParser.parse(ARGV)
Runner.new(options).run! unless options[:help]
