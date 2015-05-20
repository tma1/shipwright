require 'shipwright/cli'
require 'shipwright/hoist'

module Shipwright
  class CLI
    class Hoist < CLI

      desc "down APP_NAME ENV_NAME", "Prints environment variables to stdout"
      def down(app_name, env_name)
        puts Shipwright::Hoist.down(app_name, env_name).inspect
      end

    end
  end
end
