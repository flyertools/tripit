module TripIt
  class TransportObject < ReservationObject
    traveler_array_param :travelers
    
    def initialize(client, obj_id, source = nil)
      @client = client
      @obj_id = obj_id
      populate(source)
    end
    
    def populate(source)
      info = source || @client.get("/transport", :id => @obj_id)["TransportObject"]
      super(info)
      @segments   = []
      @travelers  = []
      checkForArray(@segments, TripIt::TransportSegment, info["Segment"])
      checkForArray(@travelers, TripIt::Traveler, info["Traveler"])
    end
    
    def segments
      @segments
    end
    def segments=(val)
      if val.is_a?(Array) && val.all? { |e| TransportSegment === e }
        @segments = val
      else
        raise ArgumentError, "#{name} must be an Array of TransportSegments"
      end
    end
  end
end