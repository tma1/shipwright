require 'thor'
require 'shipwright'

module Shipwright
  class CLI < Thor

    desc "version", "Prints shipwright version"
    def version
      puts "shipwright version: #{Shipwright::VERSION}"
    end

    desc "build", "Build and push docker image"
    def build(base=Dir.pwd)
      Shipwright::Builder.build(base)
    end
  end
end
