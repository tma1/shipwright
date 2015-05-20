require 'aws-sdk'
require 'thor'
require 'shipwright'

module Shipwright
  class CLI < Thor

    desc "version", "Prints shipwright version"
    def version
      puts "shipwright version: #{Shipwright::VERSION}"
    end

  end
end
