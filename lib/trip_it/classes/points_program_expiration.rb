module TripIt
  class PointsProgramExpiration < Base
    attr_reader :date, :amount
    
    def initialize(params = {})
      raise ArgumentError, "PointsProgramExpiration created with empty parameters" if params.empty?
      
      @date   = Date.parse(params["date"]) unless params["date"].nil?
      @amount = params["amount"]
    end
  end
end