# frozen_string_literal: true

require 'uri'
require_relative '../app_logger'

class UriVisitData
  attr_reader :uri, :ip_address, :errors

  def initialize(uri, ip_address)
    @uri = uri
    @ip_address = ip_address
    @errors = []
  end

  def valid?
    @errors.empty?
  end

  def validate!
    @errors << "#{ip_address} is invalid IP Address" unless valid_ip_address?
    @errors << "#{uri} is invalid URI" unless valid_uri?
  end

  private

  def valid_ip_address?
    IPAddr.new(ip_address)
    true
  rescue IPAddr::InvalidAddressError => e
    AppLogger.info(e)
    false
  end

  def valid_uri?
    URI(uri)
    true
  rescue URI::InvalidURIError => e
    AppLogger.info(e)
    false
  end
end
