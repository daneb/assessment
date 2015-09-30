require 'spec_helper'
require 'haversine'

describe 'Determine if customer is in 100km radius' do

  it "should return a list of unique customers" do
    custom_json = Adaptor::JSONTextFile.new('./datasource/duplicates.txt')
    all_customers = custom_json.load_customers
    nearby_customers = NearbyCustomers.new(all_customers)
    expect(nearby_customers.get_scrubbed_customer_list.length).to eq number_of_customers_in_duplicate_file
  end

  it "should ignore invalid customer names" do
    custom_json = Adaptor::JSONTextFile.new('./datasource/empty_name.txt')
    all_customers = custom_json.load_customers
    nearby_customers = NearbyCustomers.new(all_customers)
    expect(nearby_customers.get_scrubbed_customer_list.length).to eq number_of_customers_in_file_with_an_empty_name
  end

  it "should enumerate over the result to find those within 100km of Dublin office" do
    @datasource = DataAdaptor.new
    result = @datasource.retrieve_customers
    nearby_customers = NearbyCustomers.new(result)
    customers_nearby = nearby_customers.get_customers_within_radius
    expect(calculate_haversine_with_third_party(customers_nearby)).to eq true
  end
end

def calculate_haversine_with_third_party(customers_nearby)
  dublin_office_lat = 53.3381985
  dublin_office_long = -6.2592576
  customers_nearby.each do |customer|
    return false if Haversine.distance(customer["latitude"].to_f, customer["longitude"].to_f, dublin_office_lat, dublin_office_long).to_kilometers >= 100
  end
  return true
end

def number_of_customers_in_duplicate_file
  # There are two extra duplicates in the file
  manual_duplicates = 2
  file_contents = IO.readlines('./datasource/duplicates.txt')
  file_contents.length - manual_duplicates
end

def number_of_customers_in_file_with_an_empty_name
  manual_empty_names = 1
  file_contents = IO.readlines('./datasource/empty_name.txt')
  file_contents.length - manual_empty_names
end
