#!/usr/bin/env ruby

require 'optparse'
require 'logger'
require 'elasticsearch'
require 'csv'

log = Logger.new(STDOUT)

headers = [
  "cylinders",
  "displ",
  "drive",
  "fuelType",
  "fuelType1",
  "make",
  "model",
  "mpgData",
  "phevBlended",
  "transmission",
  "VClass",
  "year"
]

options = {}
OptionParser.new do |opts|

  opts.banner = "Usage: load_data -f <file.csv> -e <Elastic search URL> [-d]"

  opts.on("-f", "--file FILE", "Load CSV data from FILE") do |file|
    options[:filename] = file
  end

  opts.on("-e", "--elasticsearch URL", "Connect to elastic search at URL") do |url|
    options[:url] = url
  end

  opts.on("-d", "--dryrun", "Dry run") do 
    options[:dry] = true
  end
end.parse!


log.info("Options: #{options}")



CSV.foreach(options[:filename], headers: true) do |line|
  log.info("Line: #{line}")
end


  



   


