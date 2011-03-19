module TripIt
  class CruiseObject < ReservationObject
    traveler_array_param :traveler
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
      @segment            = []
      @traveler           = []
      @cabin_number       = info["cabin_number"]
      @cabin_type         = info["cabin_type"]
      @dining             = info["dining"]
      @ship_name          = info["ship_name"]
      chkAndPopulate(@segment, TripIt::CruiseSegment, info["Segment"])
      chkAndPopulate(@traveler, TripIt::Traveler, info["Traveler"])
      @segment = @segment.sort_by {|seg| seg.start_date_time } unless @segment.empty?
    end
    
    def segment
      @segment
    end
    def segment=(val)
      if val.is_a?(Array) && val.all? { |e| CruiseSegment === e }
        @segment = val
      else
        raise ArgumentError, "Segment must be an Array of CruiseSegments"
      end
    end
    
    def sequence
      arr = super
      arr + ["@segment", "@traveler", "@cabin_number", "@cabin_type", "@dining", "@ship_name"]      
    end
  end
end