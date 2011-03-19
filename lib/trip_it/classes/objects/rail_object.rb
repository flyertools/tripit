module TripIt
  class RailObject < ReservationObject
    traveler_array_param :traveler
    
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
      @segment   = []
      @traveler  = []
      chkAndPopulate(@segment, TripIt::RailSegment, info["Segment"])
      chkAndPopulate(@traveler, TripIt::Traveler, info["Traveler"])
      @segment = @segment.sort_by {|seg| seg.start_date_time } unless @segment.empty?
    end
    
    def segment
      @segment
    end
    def segment=(val)
      if val.is_a?(Array) && val.all? { |e| RailSegment === e }
        @segment = val
      else
        raise ArgumentError, "Segment must be an Array of RailSegments"
      end
    end
    
    def sequence
      arr = super
      arr + ["@segment", "@traveler"]
    end
  end
end