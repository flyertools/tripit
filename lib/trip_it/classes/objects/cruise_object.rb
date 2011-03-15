module TripIt
  class CruiseObject < ReservationObject
    traveler_array_param :travelers
    string_param :cabin_number, :cabin_type, :dining, :ship_name
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
    
    def populate(source)
      info = source || @client.get("/cruise", :id => @obj_id)["CruiseObject"]
      super(info)
      @segments   = []
      @travelers  = []
      chkAndPopulate(@segments, TripIt::CruiseSegment, info["Segment"])
      chkAndPopulate(@travelers, TripIt::Traveler, info["Traveler"])
      @segments = @segments.sort_by {|seg| seg.start_date_time } unless @segments.empty?
    end
    
    def segments
      @segments
    end
    def segments=(val)
      if val.is_a?(Array) && val.all? { |e| CruiseSegment === e }
        @segments = val
      else
        raise ArgumentError, "#{name} must be an Array of CruiseSegments"
      end
    end
  end
end