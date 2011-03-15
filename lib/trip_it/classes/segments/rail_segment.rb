module TripIt
  class RailSegment < Base
    datetime_param :start_date_time, :end_date_time
    address_param :start_station_address, :end_station_address
    string_param :start_station_name, :end_station_name, :carrier_name, :coach_number, :confirmation_num, :seats, :service_class, :train_number, :train_type
    attr_reader :id
    
    def initialize(params = {})
      @start_date_time        = convertDT(params["StartDateTime"])
      @end_date_time          = convertDT(params["EndDateTime"])
      @start_station_address  = TripIt::Address.new(params["StartStationAddress"])
      @end_station_address    = TripIt::Address.new(params["EndStationAddress"])
      @id                     = params["id"]
      @start_station_name     = params["start_station_name"]
      @end_station_name       = params["end_station_name"]
      @carrier_name           = params["carrier_name"]
      @coach_number           = params["coach_number"]
      @confirmation_num       = params["confirmation_num"]
      @seats                  = params["seats"]
      @service_class          = params["service_class"]
      @train_number           = params["train_number"]
      @train_type             = params["train_type"]
    end
  end
end