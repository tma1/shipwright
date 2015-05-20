require 'shipwright'

module Shipwright
  class Hoist

    AWS_NAMESPACE = 'aws:elasticbeanstalk:application:environment'.freeze

    def self.pull(app_name, env_name)
      new(app_name, env_name).down
    end

    def self.push(app_name, env_name)
      new(app_name, env_name).up
    end

    attr_reader :app_name, :env_name

    def initialize(app_name, env_name)
      @app_name, @env_name = app_name, env_name
    end

    def client
      @client ||= Aws::ElasticBeanstalk::Client.new
    end

    def down
      resources = configuration_settings.option_settings.select { |setting|
        AWS_NAMESPACE == setting.namespace 
      }
      resources.inject({}) { |acc, resource|
        acc.tap { |hash| hash[resource.option_name] = resource.value }
      }
    end

    def configuration_settings
      client.describe_configuration_settings(
        application_name: app_name, environment_name: env_name
      ).configuration_settings[0]
    end

  end
end
