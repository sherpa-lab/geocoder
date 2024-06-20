require 'geocoder/results/base'

module Geocoder::Result
  class Here < Base

    ##
    # A string in the given format.
    #
    def address(format = :full)
      address_data["label"]
    end

    ##
    # A two-element array: [lat, lon].
    #
    def coordinates
      fail unless d = @data["position"]
      [d["lat"].to_f, d["lng"].to_f]
    end

    def access_coordinates
      return unless d = @data["access"]&.first

      [d["lat"].to_f, d["lng"].to_f]
    end

    def access_latitude
      access_coordinates&.first
    end

    def access_longitude
      access_coordinates&.last
    end

    def route
      address_data["street"]
    end

    def street_address
      address_data["street"]
    end

    def street_number
      address_data["houseNumber"]
    end

    def state
      address_data["state"]
    end

    def province
      address_data["county"]
    end

    def postal_code
      address_data["postalCode"]
    end

    def city
      address_data["district"] || address_data["city"]
    end

    def state_code
      address_data["stateCode"]
    end

    def province_code
      address_data["state"]
    end

    def country
      address_data["countryName"]
    end

    def country_code
      address_data["countryCode"]
    end

    def viewport
      return [] if data["resultType"] == "place"
      map_view = data["mapView"]
      south = map_view["south"]
      west = map_view["west"]
      north = map_view["north"]
      east = map_view["east"]
      [south, west, north, east]
    end

    def quality_score
      return unless d = @data["scoring"]

      d["queryScore"]
    end

    private # ----------------------------------------------------------------

    def address_data
      @data["address"] || fail
    end
  end
end
