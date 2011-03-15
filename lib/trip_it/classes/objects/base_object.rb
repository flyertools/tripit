module TripIt
  class BaseObject < Base    
    attr_reader :id, :relative_url
    integer_param :trip_id 
    boolean_param :is_client_traveler
    string_param :display_name
    array_param :images
    
    def populate(info)
      @id                     = info["id"]
      @relative_url           = info["relative_url"]
      @trip_id                = info["trip_id"]
      @is_client_traveler     = Boolean(info["is_client_traveler"])
      @display_name           = info["display_name"]
      @images                 = []
      checkForArray(@images, TripIt::Image, info["Image"])
    end
  end
end