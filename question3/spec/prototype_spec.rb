require 'spec_helper'
require 'haversine'
include Math

describe 'Prototype Manual Haversin Formula' do
  it "should calculate the great-circle distance between two GPS cordinates" do
    R = 6371.00
    lat1 =  36.12
    long1 =  -86.67
    lat2 =  33.94
    long2 = -118.4

    dlon = long2 - long1
    dlat = lat2 - lat1
    a = calculate(dlat, lat1, lat2, dlon)
    c = 2 * atan2(sqrt(a), sqrt(1-a))
    d = R * c
    expect(d.round(1)).to eq(2886.4)

  end
end

describe 'Prototype third party formula' do
  it "should calculate the great-circle distance between two GPS cordinates" do
    intercom_lat =  36.12
    intercom_long =  -86.67
    random_lat =  33.94
    random_long = -118.4

    distance = Haversine.distance(intercom_lat, intercom_long, random_lat, random_long)

    expect(distance.to_kilometers).to eq(2886.4444428379834)

  end
end

def calculate(dlat, lat1, lat2, dlon)
  (Math.sin(rpd(dlat)/2))**2 + Math.cos(rpd(lat1)) * Math.cos((rpd(lat2))) * (Math.sin(rpd(dlon)/2))**2
end

def rpd(degree)
  degree * (PI / 180)
end
