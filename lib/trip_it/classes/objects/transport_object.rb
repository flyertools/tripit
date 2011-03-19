module TripIt
  class TransportObject < ReservationObject
    traveler_array_param :traveler
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
    
    def populate(source)
      info = source || @client.get("/transport", :id => @obj_id)["TransportObject"]
      super(info)
      @segment   = []
      @traveler  = []
      chkAndPopulate(@segment, TripIt::TransportSegment, info["Segment"])
      chkAndPopulate(@traveler, TripIt::Traveler, info["Traveler"])
      @segment = @segment.sort_by {|seg| seg.start_date_time } unless @segment.empty?
    end
    
    def segments
      @segment
    end
    def segments=(val)
      if val.is_a?(Array) && val.all? { |e| TransportSegment === e }
        @segment = val
      else
        raise ArgumentError, "Segment must be an Array of TransportSegments"
      end
    end
    
    def sequence
      arr = super
      arr + ["@segment", "@traveler"]
    end
  end
end