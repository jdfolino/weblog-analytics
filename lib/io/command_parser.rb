# frozen_string_literal: true

require 'optparse'

class CommandParser
  def self.parse(options)
    options_struct = Struct.new(:log_file, :format, :aggregator, :sort_order, :help)

    log_file = options.first unless ['-h', '--help'].include?(options.first)

    args = options_struct.new(log_file, 'stdout', 'simple', 'visits', nil)

    opt_parser = OptionParser.new do |parser|
      parser.banner = 'Usage: ruby parser.rb <input file> [options]'

      parser.on('-h', '--help', 'Help') do
        puts parser
        args.help = true
      end

      parser.on('-f=FORMAT', '--format=FORMAT', 'Output Format [stdout] default: stdout') do |f|
        args.format = f
      end

      parser.on('-a=AGGREGATOR', '--aggregator=AGGREGATOR',
                'Aggregator to use [simple|valid-only] default: simple') do |a|
        args[:aggregator] = a
      end

      parser.on('-s=SORT_ORDER', '--sort-order=SORT_ORDER', 'Sort Order [unique-visits|visits] default: visits') do |s|
        args[:sort_order] = s
      end
    end

    unless log_file
      puts opt_parser
      args.help = true
    end

    opt_parser.parse!(options)
    args
  end
end
