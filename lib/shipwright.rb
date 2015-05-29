require 'aws-sdk'
require 'bump'
require 'docker'
require 'git'
require 'forwardable'
require 'logger'

Docker.options.merge! ssl_verify_peer: false

module Shipwright

  VERSION = File.read(File.expand_path '../../VERSION', __FILE__).chomp

  extend Forwardable
  extend self

  attr_accessor :infos
  attr_accessor :errors

  self.infos  = Logger.new(STDOUT)
  self.errors = Logger.new(STDERR)

  def_delegator :infos, :info
  def_delegator :error, :error

end

require 'shipwright/builder'
require 'shipwright/elastic_beanstalk'
