module TripIt
  class TripCrsRemark < Base
    attr_reader :record_locator, :notes
    
    def initialize(params = {}) 
      raise ArgumentError, "TripCrsRemark created with empty parameters" if params.empty?
      
      @record_locator = params["record_locator"]
      @notes          = params["notes"]
    end
  end
end