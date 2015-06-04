RSpec.describe Shipwright::ElasticBeanstalk::Dockerrun do

  let(:pass) { /\:PASS\z/ }
  let(:fixs) { '../../../fixtures' }
  let(:v1)   { File.expand_path "#{fixs}/dockerrun-v1.aws.json", __FILE__ }
  let(:v2)   { File.expand_path "#{fixs}/dockerrun-v2.aws.json", __FILE__ }
  let(:run1) { described_class.new v1, 'PASS' }
  let(:run2) { described_class.new v2, 'PASS' }

  it "updates a version 1 file" do
    run1.update!
    json = JSON.parse(File.read(v1))
    expect(json['Image']['Name']).to match pass
  end

  it "updates a version 2 file" do
    run2.update!
    json = JSON.parse(File.read(v2))
    json['containerDefinitions'].each do |definition|
      expect(definition['image']).to match pass
    end
  end

  after(:each) {
    [run1, run2].each { |run|
      run.version = 'TAG'
      run.update!
    }
  }

end
