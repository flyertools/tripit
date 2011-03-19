module TripIt
  class NoteObject < BaseObject
    datetime_param :date_time
    address_param :address
    string_param :source, :text, :url, :notes
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
  
    def populate(source)
      info = source || @client.get("/note", :id => @obj_id)["NoteObject"]
      super(info)
      @date_time        = convertDT(info["DateTime"])
      @address          = TripIt::Address.new(info["Address"]) unless info["Address"].nil?
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
    
    def sequence
      arr = super
      arr + ["@date_time", "@address", "@detail_type_code", "@source", "@text", "@url", "@notes"]
    end
  end
end