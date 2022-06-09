# frozen_string_literal: true

require 'set'
class UriVisitDataAggregate
  attr_reader :uri, :visit_count

  def initialize(uri)
    @uri = uri
    @ip_addresses = ::Set.new
    @visit_count = 0
  end

  def add(ip_address)
    @ip_addresses.add(ip_address)
    @visit_count += 1
  end

  def unique_visit_count
    @ip_addresses.size
  end

  def to_s
    "uri: #{uri}, visit_count: #{visit_count}, unique_visit_count: #{unique_visit_count}"
  end
end
