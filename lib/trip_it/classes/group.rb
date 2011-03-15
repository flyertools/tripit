module TripIt
  class Group < Base
    attr_reader :display_name, :url
    
    def initialize(params = {})
      raise ArgumentError, "Group created with empty parameters" if params.empty? 
      
      @display_name = params["display_name"]
      @url          = params["url"]
    end
  end
end