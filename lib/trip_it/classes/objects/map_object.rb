module TripIt
  class MapObject < BaseObject
    datetime_param :date_time
    address_param :address
  
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
  
    def populate(source)
      info = source || @client.get("/map", :id => @obj_id)["MapObject"]
      super(info)
      @date_time = convertDT(info["DateTime"])
      @address  = TripIt::Address.new(info["Address"])
    end
    
    def sequence
      arr = super
      arr + ["@date_time","@address"]
    end
  end
end