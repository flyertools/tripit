module TripIt
  class ActivityObject < ReservationObject    
    datetime_param :start_date_time
    time_param :end_time
    address_param :address
    traveler_array_param :participant
    string_param :location_name
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
    
    def populate(source)
      info = source || @client.get("/activity", :id => @obj_id)["ActivityObject"]
      super(info)
      @start_date_time      = convertDT(info["StartDateTime"])
      @end_time             = Time.parse(info["end_time"]) unless info["end_time"].nil?
      @address              = TripIt::Address.new(info["Address"]) unless info["Address"].nil?
      @location_name        = info["location_name"]
      @detail_type_code     = info["detail_type_code"]
      @participant          = []
      chkAndPopulate(@participant, TripIt::Traveler, info["Participant"])
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
    
    def sequence
      arr = super
      arr + ["@start_date_time", "@end_time", "@address", "@participant", "@detail_type_code", "@location_name"]
    end
  end
end