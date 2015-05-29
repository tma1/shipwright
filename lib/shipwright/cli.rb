require 'thor'
require 'shipwright'

module Shipwright
  class CLI < Thor

    desc "version", "Prints shipwright version"
    def version
      puts "shipwright version: #{Shipwright::VERSION}"
    end

    desc "build [base] [shipyard]", "Build and push docker image"
    def build(base=Dir.pwd, shipyard=nil)
      Shipwright::Builder.build(base, shipyard)
    rescue Shipwright::Builder::MissingShipyardError
      puts "Set SHIPYARD in your environment or pass it to the build command"
      exit 1
    end
  end
end
