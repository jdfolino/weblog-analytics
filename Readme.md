# Weblog Parser

## Usage

Usage: ruby parser.rb <input file> [options]
-h, --help                       Help
-f, --format=FORMAT              Output Format [stdout] default: stdout
-a, --aggregator=AGGREGATOR      Aggregator to use [simple|valid-only] default: simple
-s, --sort-order=SORT_ORDER      Sort Order [unique-visits|visits] default: visits

### Usage Examples

#### Basic
`bundle exec ruby parser.rb spec/fixtures/full_webserver_valid_ips.log`

#### Order by Unique Visits
`ruby parser.rb spec/fixtures/full_webserver_valid_ips.log -s unique-visits`

#### Count records with invalid URIs and/or IPs
`ruby parser.rb spec/fixtures/full_webserver_invalid_ips.log -a simple`

## Design Decisions

### Assumptions
* Invalid IP Addresses will not be counted
* IPv6 is not a requirement but should be considered
* Only URL paths will be supported i.e. `/pathj`

### Extensibility
####CSVParser
It is a subclass of the BaseParser. This enables a different parser to be implemented by implementing the `run` method

#### Aggregators
It is a subclass of the BaseAggregator. This enables a different parser to be implemented by implementing the `add` method

#### Formatter
It is a subclass of the BaseFormatter. This enables a new formatter to be implemented by implementing the `display` method

#### IPV6
ipaddr stdlib is used for validation which supports IPv6

### Performance
The built in CSVParser processes line by line and does not load the whole document into memory. If a faster CSV parser
comes along later this can be implemented by subclassing the BaseParser

Unique ip addresses are saved in a set to conserve memory (as opposed to putting them all into an array and counting the unique instances)


## Version Two Features
These are the features that would get added if more time was given:
* Improve `test coverage`
* More comprehensive logging
* Windows batch file to run program
* More output formats (PDF, XML, HTML)
* Command Line Option to allow invalid IP addresses to be included in the aggregate data (needs to be discussed)
* Consider moving the validation to use ActiveModel
