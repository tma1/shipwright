module Shipwright
  class Environment
    AWS_NAMESPACE = 'aws:elasticbeanstalk:application:environment'.freeze

    def self.pull(app_name, env_name)
      new(app_name, env_name).tap(&:pull)
    end

    attr_reader :app_name, :env_name
    attr_accessor :env

    def initialize(app_name, env_name)
      @app_name, @env_name, @env = app_name, "#{app_name}-#{env_name}", {}
    end

    def client
      @client ||= Aws::ElasticBeanstalk::Client.new
    end

    def pull
      resources = configuration_settings.option_settings.select { |setting|
        AWS_NAMESPACE == setting.namespace 
      }
      self.env = resources.inject({}) { |acc, resource|
        acc.tap { |hash| hash[resource.option_name] = resource.value }
      }
    end

    def configuration_settings
      client.describe_configuration_settings(
        application_name: app_name, environment_name: env_name
      ).configuration_settings[0]
    end

    def to_s
      env.map { |k,v| "#{k}=#{v}" }.join("\n")
    end

    def save
      puts "save some env son..."
    end

  end
end
