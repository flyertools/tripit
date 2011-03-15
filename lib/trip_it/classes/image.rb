module TripIt
  class Image < Base
    string_param :caption, :url
    
    def initialize(params = {})      
      @caption  = params["caption"]
      @url      = params["url"]
    end
  end
end