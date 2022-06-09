# frozen_string_literal: true

require 'simplecov'

require_relative '../lib/app_logger'
SimpleCov.start

AppLogger.instance.level = 3
