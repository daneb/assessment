require 'spec_helper'

describe Report do
  before :all do
    @datasource = DataAdaptor.new
    result = @datasource.retrieve_customers
    nearby_customers = NearbyCustomers.new(result)
    @customers_nearby = nearby_customers.get_customers_within_radius
  end

  describe 'See the within radius customer names along with id in ascending order' do
    it "should transform the customers into a report object" do
      report_objects = Report.transform_for_report(@customers_nearby)
      expect(report_objects.length).to be > 1
      expect(report_objects[0].class).to be Helpers::CustomerReport
    end

    it "should return the customer name and id in ascending order" do
      report_objects = Report.transform_for_report(@customers_nearby)
      sorted = Report.sort_ascending(report_objects)
      expect(determine_if_ascending(sorted)).to eq true
    end

    it "should write a report to disk" do
      report = './reports/nearby_customer.txt'
      FileUtils.rm(report) if File.exists?(report)
      report_objects = Report.transform_for_report(@customers_nearby)
      sorted = Report.sort_ascending(report_objects)
      Report.write_report_to_disk(sorted)
      expect(File.size(report)).to be > 1
      expect(File.exists?(report)).to eq true
    end
  end
end

def determine_if_ascending(report_objects)
  last_value = 0
  report_objects.each do |report_object|
    return false if report_object.user_id < last_value
    last_value = report_object.user_id
  end
  true
end
