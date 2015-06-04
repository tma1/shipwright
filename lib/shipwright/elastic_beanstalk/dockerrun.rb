module Shipwright
  module ElasticBeanstalk
    class Dockerrun
      attr_accessor :path, :version

      def initialize(path, version)
        self.path, self.version = path, version
      end

      def json
        @json ||= JSON.parse(File.read(path))
      end

      def run_version
        json.fetch('AWSEBDockerrunVersion')
      end

      def update!
        if respond_to?("update_#{run_version}")
          send("update_#{run_version}")
        else
          invalid_version_error!
        end
        File.open(path, 'wb') { |file| file.write JSON.pretty_generate(json) }
      end

      def update_1
        json['Image']['Name'] = image(json['Image']['Name'])
      end

      def update_2
        json['containerDefinitions'].each do |container|
          container['image'] = image(container['image'])
        end
      end
      
      def image(name)
        bits = name.to_s.split(':').tap(&:pop)
        bits.push(version).join(':')
      end

      def invalid_version_error!
        raise InvalidDockerrunVersionError.new(
          "invalid AWSEBDockerrunVersion version: #{run_version.inspect}")
      end

      InvalidDockerrunVersionError = Class.new(StandardError)
    end
  end
end

