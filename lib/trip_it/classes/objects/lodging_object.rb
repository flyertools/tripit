module TripIt
  class LodgingObject < ReservationObject
    datetime_param :start_date_time, :end_date_time
    string_param :number_guests, :number_rooms, :room_type
    address_param :address
    traveler_array_param :guest
    
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
      @guest                = []
      chkAndPopulate(@guest, TripIt::Traveler, info["Guest"])
    end
    
    def sequence
      arr = super
      arr + ["@start_date_time", "@end_date_time", "@address", "@guest", "@number_guests", "@number_rooms", "@room_type"]
    end
  end
end