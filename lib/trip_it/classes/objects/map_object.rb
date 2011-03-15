module TripIt
  class MapObject < BaseObject
    datetime_param :datetime
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
      @datetime = convertDT(info["DateTime"])
      @address  = TripIt::Address.new(info["Address"])
    end
  end
end