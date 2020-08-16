#!/usr/bin/env ruby

require 'optparse'
require 'logger'
require 'elasticsearch'
require 'csv'
require 'digest'


$log = Logger.new(STDERR)

CSV_HEADERS = [
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

VEHICLE_ID_FIELDS = [
  "make",
  "model",
  "year",
  "drive",
  "transmission",
  "cylinders",
  "displ"
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


$log.debug("Options: #{options}")


def calculateId(vehicleHash)
  stringToHash = ""

  $log.debug("Calculating ID from hash: #{vehicleHash}")
  
  VEHICLE_ID_FIELDS.each do |field|
    $log.debug("Getting field: #{field}")
    fieldValue = vehicleHash[field]
    stringToHash += fieldValue if fieldValue
  end

  Digest::SHA2.hexdigest(stringToHash)
end


$log.debug("Getting client connection to Elasticsearch")

elasticsearchClient = Elasticsearch::Client.new url: options[:url], log: true


$log.debug("Iterating through data file")

CSV.foreach(options[:filename], headers: true) do |line|
  $log.debug("Line: #{line}")
  hashToStore = line.to_hash

  id = calculateId(hashToStore)
  $log.debug("Calulated ID: #{id}")

  hashToStore["id"] = id

  $log.debug("Hash: #{hashToStore}")

  if options[:dry] == true
    $log.debug("Skipping adding this entry")
  else
    $log.debug("Attempting to add to the index")
    elasticsearchClient.index id: id, index: "vehicle", body: hashToStore
  end
end

