module TripIt
  class FlightStatus < Base
    attr_reader :scheduled_departure_date_time, :estimated_departure_date_time, :scheduled_arrival_date_time, :estimated_arrival_date_time, \
                :is_connection_at_risk, :departure_terminal, :departure_gate, :arrival_terminal, :arrival_gate, :layover_minutes, :baggage_claim, \
                :flight_status, :airport_code, :last_modified
                
    def initialize(params = {})
      raise ArgumentError, "FlightStatus created with empty parameters" if params.empty? 

      @scheduled_departure_date_time  = convertDT(params["ScheduledDepartureDateTime"])
      @estimated_departure_date_time  = convertDT(params["EstimatedDepartureDateTime"])
      @scheduled_arrival_date_time    = convertDT(params["ScheduledArrivalDateTime"])
      @estimated_arrival_date_time    = convertDT(params["EstimatedArrivalDateTime"])
      @is_connection_at_risk          = Boolean(params["is_connection_at_risk"])
      @departure_terminal             = params["departure_terminal"]
      @departure_gate                 = params["departure_gate"]
      @arrival_terminal               = params["arrival_terminal"]
      @arrival_gate                   = params["arrival_gate"]
      @layover_minutes                = params["layover_minutes"]
      @baggage_claim                  = params["baggage_claim"]
      @flight_status                  = params["flight_status"]
      @airport_code                   = params["airport_code"]
      @last_modified                  = params["last_modified"]
    end
  end
end