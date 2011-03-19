module TripIt
  class DirectionsObject < BaseObject
    datetime_param :date_time
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
      @date_time      = convertDT(info["DateTime"])
      @start_address  = TripIt::Address.new(info["StartAddress"])
      @end_address    = TripIt::Address.new(info["EndAddress"])
    end
    
    def sequence
      arr = super
      arr + ["@date_time", "@start_address", "@end_address"]
    end
  end
end