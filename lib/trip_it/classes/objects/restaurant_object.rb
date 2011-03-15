module TripIt
  class RestaurantObject < ReservationObject
    datetime_param :datetime
    address_param :address
    traveler_param :reservation_holder
    string_param :cuisine, :dress_code, :hours, :number_patrons, :price_range
    
    def initialize(client, obj_id, source = nil)
      @client = client
      @obj_id = obj_id
      populate(source)
    end
    
    def populate(source)
      info = source || @client.get("/restaurant", :id => @obj_id)["RestaurantObject"]
      super(info)
      @datetime           = convertDT(info["DateTime"])
      @address            = TripIt::Address.new(info["Address"])
      @reservation_holder = TripIt::Traveler.new(info["ReservationHolder"])
      @cuisine            = info["cuisine"]
      @dress_code         = info["dress_code"]
      @hours              = info["hours"]
      @number_patrons     = info["number_patrons"]
      @price_range        = info["price_range"]
    end
  end
end