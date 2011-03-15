module TripIt
  class AirObject < ReservationObject
    attr_reader :info
    traveler_array_param :travelers
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
    
    def populate(source)
      info = source || @client.get("/air", :id => @obj_id)["AirObject"]
      super(info)
      @segments   = []
      @travelers  = []
      chkAndPopulate(@segments, TripIt::AirSegment, info["Segment"])
      chkAndPopulate(@travelers, TripIt::Traveler, info["Traveler"])
    end
    
    def segments
      @segments
    end
    def segments=(val)
      if val.is_a?(Array) && val.all? { |e| AirSegment === e }
        @segments = val
      else
        raise ArgumentError, "Segments must be an Array of AirSegments"
      end
    end
  end
end