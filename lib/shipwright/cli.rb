require 'thor'

module Shipwright
  class CLI < Thor

    desc "version", "Prints shipwright version"
    def version
      puts "shipwright version: #{Shipwright::VERSION}"
    end

  end
end

require 'shipwright/cli/harbor'
require 'shipwright/cli/hoist'
require 'shipwright/cli/ship'
