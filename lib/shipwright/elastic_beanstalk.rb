require 'yaml'
require 'json'
require 'fileutils'
require 'zip'

module Shipwright
  module ElasticBeanstalk

    EB_CONFIG     = ".elasticbeanstalk/config.yml"
    EB_EXTENSIONS = '.ebextensions'
    DOCKERRUN     = 'Dockerrun.aws.json'

    extend self

    def update_dockerrun
      dockerrun  = JSON.parse(File.read DOCKERRUN)

      dockerrun['containerDefinitions'].each do |container|
        bits = container['image'].to_s.split(':').tap(&:pop)
        container['image'] = bits.push(version).join(':')
      end

      File.open(DOCKERRUN, 'wb') { |file|
        file.write JSON.pretty_generate(dockerrun) }
    end

    def generate_artifact
      FileUtils.mkdir_p File.dirname(artifact_path)
      FileUtils.rm artifact_path, force: true
      Zip::File.open(artifact_path, Zip::File::CREATE) do |zip|
        zip.add DOCKERRUN, DOCKERRUN
        ebexts = Dir.glob(File.join EB_EXTENSIONS, '*')
        if ebexts.any?
          zip.mkdir EB_EXTENSIONS
          ebexts.each { |ext| zip.add ext, ext }
        end
      end
    end

    def update_ebconfig
      config = YAML.load_file EB_CONFIG
      config['deploy'] ||= {}
      config['deploy']['artifact'] = artifact_path
      File.open(EB_CONFIG, 'wb') { |f| f.write config.to_yaml[4..-1] } # skip ---\n
    rescue Errno::ENOENT
    end

    def artifact_path
      File.join Dir.pwd, 'builds', "#{application}-#{version}.zip"
    end

    def version
      Builder.version
    end

    def application
      Builder.application
    end

  end
end
