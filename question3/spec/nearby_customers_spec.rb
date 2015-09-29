require 'spec_helper.rb'

describe NearbyCustomers do
  describe "Determine if customers are within a 100km radius" do
    it "should retrieve the data from the datasource" do
      datasource = DataAdaptor.new
      result = datasource.retrieve_customers
      expect(result.length).to be > 0
    end
  end
end