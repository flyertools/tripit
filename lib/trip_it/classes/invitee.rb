module TripIt
  class Invitee < Base
    attr_reader :is_read_only, :is_traveler, :profile
    
    def initialize(params, profile)
      raise ArgumentError, "Invitee created with empty parameters" if params.empty? 
      
      @is_read_only = Boolean(params['is_read_only'])
      @is_traveler  = Boolean(params['is_traveler'])
      @profile      = profile
    end
  end
end