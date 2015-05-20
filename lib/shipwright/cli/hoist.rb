module Shipwright
  class CLI
    class Hoist < CLI

      desc "down APP_NAME ENV_NAME", "Get environment variables from elastic beanstalk environment"
      method_options save: :boolean
      def down(app_name, env_name)
        env = Shipwright::Environment.pull(app_name, env_name)
        env.save if options[:save]

        puts env.to_s
      end

      desc "up APP_NAME ENV_NAME", "Hoists environment variables in config/{stage}.env to an elastic beanstalk environment"
      def up(app_name, env_name)
        Shipwright::Environment.push(app_name, env_name, dock.env)
      end

    end
  end
end
