module TripIt
  class Address < Base
    string_param :address, :addr1, :addr2, :city, :state, :zip, :country
    attr_reader :latitude, :longitude
    
    def initialize(params = {})
      @address    = params["address"]
      @addr1      = params["addr1"]
      @addr2      = params["addr2"]
      @city       = params["city"]
      @state      = params["state"]
      @zip        = params["zip"]
      @country    = params["country"]
      @latitude   = params["latitude"]
      @longitude  = params["longitude"]
    end
  end
end