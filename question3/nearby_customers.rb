require './helpers/haversine'

class NearbyCustomers
  attr_accessor :customers
  @@dublin_office_lat = 53.3381985
  @@dublin_office_long = -6.2592576

  def initialize(all_customers)
    @customers = all_customers["customers"]["items"]
  end

  def get_scrubbed_customer_list
    get_unique_customers
    ignore_customers_with_invalid_names
  end

  def get_customers_within_radius
    get_scrubbed_customer_list
    get_list_of_customers_within_radius
  end

  private
  def get_unique_customers
    @customers.uniq!
  end

  def ignore_customers_with_invalid_names
    @customers =  @customers.select { |customer| !!(customer["name"] =~ /[a-z]/i) }
  end

  def get_list_of_customers_within_radius
    customers_in_radius = []
    @customers.each do |customer|
      distance_between = get_distance_to_dublin_office(customer["latitude"].to_f, customer["longitude"].to_f)
      customers_in_radius << customer if distance_between < 100
    end
    customers_in_radius
  end

  def get_distance_to_dublin_office(lat1, long1)
    Helpers::Haversine.distance_between_two_points(lat1, long1, @@dublin_office_lat, @@dublin_office_long)
  end
end
