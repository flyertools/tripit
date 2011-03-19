module TripIt
  class ProfileEmailAddress < Base
    attr_reader :address
    boolean_read_param :is_auto_import, :is_confirmed, :is_primary
    
    def initialize(params = {}) 
      raise ArgumentError, "ProfileEmailAddress created with empty parameters" if params.empty?
      
      @address        = params["address"]
      @is_auto_import = Boolean(params["is_auto_import"])
      @is_confirmed   = Boolean(params["is_confirmed"])
      @is_primary     = Boolean(params["is_primary"])
    end
  end
end