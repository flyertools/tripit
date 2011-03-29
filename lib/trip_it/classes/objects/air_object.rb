module TripIt
  class AirObject < ReservationObject
    traveler_array_param :traveler
    
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
      @segment   = []
      @traveler  = []
      chkAndPopulate(@segment, TripIt::AirSegment, info["Segment"])
      chkAndPopulate(@traveler, TripIt::Traveler, info["Traveler"])
    end
    
    def segment
      @segment
    end
    def segment=(val)
      if val.is_a?(Array) && val.all? { |e| AirSegment === e }
        @segment = val
      else
        raise ArgumentError, "Segment must be an Array of AirSegments"
      end
    end
    
    def sequence
      arr = super
      arr + ["@segment", "@traveler"]
    end
  end
end