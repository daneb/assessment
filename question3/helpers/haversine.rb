module Helpers
  module Haversine

    # http://mathforum.org/library/drmath/view/51879.html
    # https://en.wikipedia.org/wiki/Great-circle_distance
    # http://www.movable-type.co.uk/scripts/latlong.html
    # Radius of the earth
    @@R = 6371.00

    def self.distance_between_two_points(lat1, long1, lat2, long2)
      dlon = long2 - long1
      dlat = lat2 - lat1
      a = calculate(dlat, lat1, lat2, dlon)
      c = 2 * atan2(sqrt(a), sqrt(1-a))
      d = @@R * c
      return d
    end

    private
    def self.calculate(dlat, lat1, lat2, dlon)
      (Math.sin(rpd(dlat)/2))**2 + Math.cos(rpd(lat1)) * Math.cos((rpd(lat2))) * (Math.sin(rpd(dlon)/2))**2
    end

    def self.rpd(degree)
      degree * (PI / 180)
    end
  end
end
