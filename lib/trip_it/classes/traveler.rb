module TripIt
  class Traveler < Base
    string_param :first_name, :middle_name, :last_name, :frequent_traveler_num, :frequent_traveler_supplier, :meal_preference, :seat_preference, :ticket_num
  
    def initialize(params = {})     
      @first_name                   = params["first_name"]
      @middle_name                  = params["middle_name"]
      @last_name                    = params["last_name"]
      @frequent_traveler_num        = params["frequent_traveler_num"]
      @frequent_traveler_supplier   = params["frequent_traveler_supplier"]
      @meal_preference              = params["meal_preference"]
      @seat_preference              = params["seat_preference"]
      @ticket_num                   = params["ticket_num"]
    end
  end
end