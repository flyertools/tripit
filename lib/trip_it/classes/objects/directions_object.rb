module TripIt
  class DirectionsObject < BaseObject
    datetime_param :datetime
    address_param :start_address, :end_address
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
    
    def populate(source)
      info = source || @client.get("/directions", :id => @obj_id)["DirectionsObject"]
      super(info)
      @datetime       = convertDT(info["DateTime"])
      @start_address  = TripIt::Address.new(info["StartAddress"])
      @end_address    = TripIt::Address.new(info["EndAddress"])
    end
  end
end