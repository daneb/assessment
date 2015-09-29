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

    it "should parse the file and return a hash customer list" do
      customers = @datasource.retrieve_customers
      expect(customers.has_key?("customers")).to be true
    end
  end
end
