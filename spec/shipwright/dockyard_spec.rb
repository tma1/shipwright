RSpec.describe Shipwright::Dockyard do

  context "without HARBOR_PATH set" do
    before(:each) { ENV.delete 'HARBOR_PATH' }

    it "assumes the current directory is the HARBOR_PATH" do
      expect(described_class.harbor_path).to eq `pwd`
    end
  end

  context "with HARBOR_PATH set" do
    before(:each) { ENV['HARBOR_PATH'] = 'fixtures/harbor/something' }

    it "sets the harbor path to the ENV" do
      expect(described_class.harbor_path).to eq 'something'
    end
  end

end
