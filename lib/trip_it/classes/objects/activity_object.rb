module TripIt
  class ActivityObject < ReservationObject    
    datetime_param :start_date_time, :end_time
    address_param :address
    traveler_array_param :participants
    string_param :location_name
    
    def initialize(client, obj_id, source = nil)
      @client = client
      @obj_id = obj_id
      populate(source)
    end
    
    def populate(source)
      info = source || @client.get("/activity", :id => @obj_id)["ActivityObject"]
      super(info)
      @start_date_time      = convertDT(info["StartDateTime"])
      @end_date_time        = convertDT(info["EndDateTime"])
      @address              = TripIt::Address.new(info["Address"])
      @location_name        = info["location_name"]
      @detail_type_code     = info["detail_type_code"]
      @participants         = []
      checkForArray(@participants, TripIt::Traveler, info["Participant"])
    end
    
    def detail_type_code
      @detail_type_code
    end
    def detail_type_code=(val)
      if ACTIVITY_DETAIL_TYPE_CODE.has_key?(val)
        @detail_type_code = val
      else
        raise ArgumentError, "detail_type_code must have a valid ACTIVITY_DETAIL_TYPE_CODE"
      end
    end
  end
end