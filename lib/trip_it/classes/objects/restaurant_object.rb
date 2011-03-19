module TripIt
  class RestaurantObject < ReservationObject
    datetime_param :date_time
    address_param :address
    traveler_param :reservation_holder
    string_param :cuisine, :dress_code, :hours, :number_patrons, :price_range
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
    
    def populate(source)
      info = source || @client.get("/restaurant", :id => @obj_id)["RestaurantObject"]
      super(info)
      @date_time          = convertDT(info["DateTime"])
      @address            = TripIt::Address.new(info["Address"]) unless info["Address"].nil?
      @reservation_holder = TripIt::Traveler.new(info["ReservationHolder"]) unless info["ReservationHolder"].nil?
      @cuisine            = info["cuisine"]
      @dress_code         = info["dress_code"]
      @hours              = info["hours"]
      @number_patrons     = info["number_patrons"]
      @price_range        = info["price_range"]
    end
    
    def sequence
      arr = super
      arr + ["@date_time", "@address", "@reservation_holder", "@cuisine", "@dress_code", "@hours", "@number_patrons", "@price_range"]      
    end
  end
end