module TripIt
  class NoteObject < BaseObject
    datetime_param :datetime
    address_param :address
    string_param :source, :text, :url, :notes
    
    def initialize(client, obj_id, source = nil)
      @client = client
      @obj_id = obj_id
      populate(source)
    end
  
    def populate(source)
      info = source || @client.get("/note", :id => @obj_id)["NoteObject"]
      super(info)
      @datetime         = convertDT(info["DateTime"])
      @address          = TripIt::Address.new(info["Address"])
      @source           = info["source"]
      @text             = info["text"]
      @url              = info["url"]
      @notes            = info["notes"]
      @detail_type_code = info["detail_type_code"]
    end
    
    def detail_type_code
      @detail_type_code
    end
    def detail_type_code=(val)
      if NOTE_DETAIL_TYPE_CODE.has_key?(val)
        @detail_type_code = val
      else
        raise ArgumentError, "detail_type_code must have a valid NOTE_DETAIL_TYPE_CODE"
      end
    end
  end
end