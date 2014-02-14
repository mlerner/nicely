module ApplicationHelper
  def devise_view?
    devise_controller?
  end

  def gravatar_url(email, size = '40')
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?s=#{size}&d=mm"
  end

  def haversine_distance(first_lat, first_lon, second_lat, second_lon, format = :miles)
    earthRadius = 6371 # Earth's radius in KM

    # convert degrees to radians
    def deg_to_rad(value)
      unless value.nil? or value == 0
        value = (value/180) * Math::PI
      end
      return value
    end

    delta_lat = (second_lat - first_lat)
    delta_lon = (second_lon-first_lon)
    delta_lat_rad = deg_to_rad(delta_lat)
    delta_lon_rad = deg_to_rad(delta_lon)

    # Calculate square of half the chord length between latitude and longitude
    a = Math.sin(delta_lat_rad/2) * Math.sin(delta_lat_rad/2) +
        Math.cos((first_lat/180 * Math::PI)) * Math.cos((second_lat/180 * Math::PI)) *
            Math.sin(delta_lon_rad/2) * Math.sin(delta_lon_rad/2);

    # Calculate the angular distance in radians
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    distance = earthRadius * c
    if format == :miles
      return distance * 0.621371
    else
      return distance
    end

  end

end
