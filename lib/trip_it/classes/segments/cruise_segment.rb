module TripIt
  class CruiseSegment < Base
    datetime_param :start_date_time, :end_date_time
    address_param :location_address
    string_param :location_name
    attr_reader :id
    
    def initialize(params = {})
      @start_date_time  = convertDT(params["StartDateTime"])
      @end_date_time    = convertDT(params["EndDateTime"])
      @location_address = TripIt::Address.new(params["LocationAddress"]) unless params["LocationAddress"].nil?
      @location_name    = params["location_name"]
      @id               = params["id"]
      @detail_type_code = params["detail_type_code"]
    end
    
    def detail_type_code
      @detail_type_code
    end
    def detail_type_code=(val)
      if CRUISE_DETAIL_TYPE_CODE.has_key?(val)
        @detail_type_code = val
      else
        raise ArgumentError, "detail_type_code must be a valid CRUISE_DETAIL_TYPE_CODE"
      end
    end
  end
end