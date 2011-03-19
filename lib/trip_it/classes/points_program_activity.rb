module TripIt
  class PointsProgramActivity < Base
    attr_reader :date, :description, :base, :bonus, :total
    
    def initialize(params = {})
      raise ArgumentError, "PointsProgramActivity created with empty parameters" if params.empty?
      
      @date         = Date.parse(params["date"]) unless params["date"].nil?
      @description  = params["description"]
      @base         = params["base"]
      @bonus        = params["bonus"]
      @total        = params["total"]
    end
  end
end