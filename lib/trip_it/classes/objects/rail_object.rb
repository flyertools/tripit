module TripIt
  class RailObject < ReservationObject
    traveler_array_param :travelers
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
    
    def populate(source)
      info = source || @client.get("/rail", :id => @obj_id)["RailObject"]
      super(info)
      @segments   = []
      @travelers  = []
      checkForArray(@segments, TripIt::RailSegment, info["Segment"])
      checkForArray(@travelers, TripIt::Traveler, info["Traveler"])
    end
    
    def segments
      @segments
    end
    def segments=(val)
      if val.is_a?(Array) && val.all? { |e| RailSegment === e }
        @segments = val
      else
        raise ArgumentError, "#{name} must be an Array of RailSegments"
      end
    end
  end
end