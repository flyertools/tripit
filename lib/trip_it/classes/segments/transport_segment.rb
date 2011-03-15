module TripIt
  class TransportSegment < Base
    datetime_param :start_date_time, :end_date_time
    address_param :start_location_address, :end_location_address
    string_param :start_location_name, :end_location_name, :carrier_name, :confirmation_num, :number_passengers, :vehicle_description
    attr_reader :id
    
    def initialize(params = {})
      @start_date_time        = convertDT(params["StartDateTime"])
      @end_date_time          = convertDT(params["EndDateTime"])
      @start_location_address = TripIt::Address.new(params["StartLocationAddress"])
      @end_location_address   = TripIt::Address.new(params["EndLocationAddress"])
      @start_location_name    = params["start_location_name"]
      @end_location_name      = params["end_location_name"]
      @carrier_name           = params["carrier_name"]
      @confirmation_num       = params["confirmation_num"]
      @number_passengers      = params["number_passengers"]
      @vehicle_description    = params["vehicle_description"]
      @id                     = params["id"]
      @detail_type_code       = params["detail_type_code"]
    end
    
    def detail_type_code
      @detail_type_code
    end
    def detail_type_code=(val)
      if TRANSPORT_DETAIL_TYPE_CODE.has_key?(val)
        @detail_type_code = val
      else
        raise ArgumentError, "detail_type_code must be a valid TRANSPORT_DETAIL_TYPE_CODE"
      end
    end
  end
end