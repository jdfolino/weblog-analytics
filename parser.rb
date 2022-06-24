#!/usr/local/bin/ruby
# frozen_string_literal: true

require_relative 'lib/runner_factory'
require_relative 'lib/io/command_parser'
require_relative 'lib/app_logger'
AppLogger.instance.level = ENV['LOG_LEVEL'] || 3
options = CommandParser.parse(ARGV)
RunnerFactory.build(options).run! unless options[:help]
