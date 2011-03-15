module TripIt
  class AirSegment < Base
    attr_reader :status, :start_airport_latitude, :start_airport_longitude, :end_airport_latitude, :end_airport_longitude, :marketing_airline_code, \
                :operating_airline_code, :alternate_flights_url, :aircraft_display_name, :conflict_resolution_url, :is_hidden, :id
    
    string_param :start_city_name, :start_gate, :start_terminal, :end_city_name, :end_gate, :end_terminal, :marketing_airline, :marketing_flight_number, \
                 :operating_airline, :operating_flight_number, :aircraft, :distance, :duration, :entertainment, :meal, :notes, :ontime_perc, \
                 :seats, :service_class, :stops, :baggage_claim, :check_in_url
    
    datetime_param :start_date_time, :end_date_time
    
    airportcode_param :start_airport_code, :end_airport_code
    
    def initialize(params = {})       
      @status                   = TripIt::FlightStatus.new(params["Status"])
      @start_airport_latitude   = params["start_airport_latitude"]
      @start_airport_longitude  = params["start_airport_longitude"]
      @end_airport_latitude     = params["end_airport_latitude"]
      @end_airport_longitude    = params["end_airport_longitude"]
      @marketing_airline_code   = params["marketing_airline_code"]
      @operating_airline_code   = params["operating_airline_code"]
      @alternate_flights_url    = params["alternate_flights_url"]
      @aircraft_display_name    = params["aircraft_display_name"]
      @conflict_resolution_url  = params["conflict_resolution_url"]
      @is_hidden                = Boolean(params["is_hidden"])
      @id                       = params["id"]
      @start_city_name          = params["start_city_name"]
      @start_gate               = params["start_gate"]
      @start_terminal           = params["start_terminal"]
      @end_city_name            = params["end_city_name"]
      @end_gate                 = params["end_gate"]
      @end_terminal             = params["end_terminal"]
      @marketing_airline        = params["marketing_airline"]
      @marketing_flight_number  = params["marketing_flight_number"]
      @operating_airline        = params["operating_airline"]
      @operating_flight_number  = params["operating_flight_number"]
      @aircraft                 = params["aircraft"]
      @distance                 = params["distance"]
      @duration                 = params["duration"]
      @entertainment            = params["entertainment"]
      @meal                     = params["meal"]
      @notes                    = params["notes"]
      @ontime_perc              = params["ontime_perc"]
      @seats                    = params["seats"]
      @service_class            = params["service_class"]
      @stops                    = params["stops"]
      @baggage_claim            = params["baggage_claim"]
      @check_in_url             = params["check_in_url"]
      @start_date_time          = convertDT(params["StartDateTime"])
      @end_date_time            = convertDT(params["EndDateTime"])
      @start_airport_code       = params["start_airport_code"]
      @end_airport_code         = params["end_airport_code"]
    end
  end
end