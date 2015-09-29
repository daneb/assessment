require 'spec_helper.rb'
require 'json'

describe NearbyCustomers do
  before :all do
    @datasource = DataAdaptor.new
  end

  describe "Determine if customers are within a 100km radius" do
    it "should retrieve the data from the datasource" do
      result = @datasource.retrieve_customers
      expect(result.length).to be > 0
    end

    it "should parse a multiple root json encoded file and return a hash customer list" do
      customers = @datasource.retrieve_customers
      expect(customers.has_key?("customers")).to be true
    end

    it "should return an empty hash if the data source is empty" do
      custom_json = Adaptor::JSONTextFile.new('./datasource/empty.txt')
      result = custom_json.load_customers
      expect(result.data).to be {}
      expect(result.error).to eq "Datasource empty"
    end

  end
end
