module TripIt
  class LodgingObject < ReservationObject
    datetime_param :start_date_time, :end_date_time
    string_param :number_guests, :number_rooms, :room_type
    address_param :address
    traveler_array_param :guests
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
    
    def populate(source)
      info = source || @client.get("/lodging", :id => @obj_id)["LodgingObject"]
      super(info)
      @start_date_time      = convertDT(info["StartDateTime"])
      @end_date_time        = convertDT(info["EndDateTime"])
      @number_guests        = info["number_guests"]
      @number_rooms         = info["number_rooms"]
      @room_type            = info["room_type"]
      @address              = TripIt::Address.new(info["Address"])
      @guests               = []
      chkAndPopulate(@guests, TripIt::Traveler, info["Guest"])
    end
  end
end