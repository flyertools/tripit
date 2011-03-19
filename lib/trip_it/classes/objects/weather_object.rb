module TripIt
  class WeatherObject < BaseObject
    date_param :date
    string_param :location
    float_param :avg_high_temp_c, :avg_low_temp_c, :avg_wind_speed_kn, :avg_precipitation_cm, :avg_snow_depth_cm
    
    def initialize(client, obj_id = nil, source = nil)
      @client = client
      unless obj_id.nil?
        @obj_id = obj_id
        populate(source)
      end
    end
    
    def populate(source)
      info = source || @client.get("/weather", :id => @obj_id)["WeatherObject"]
      super(info)
      @date                 = Date.parse(info["date"]) unless info["date"].nil?
      @location             = info["location"]
      @avg_high_temp_c      = info["avg_high_temp_c"].to_f
      @avg_low_temp_c       = info["avg_low_temp_c"].to_f
      @avg_wind_speed_kn    = info["avg_wind_speed_kn"].to_f
      @avg_precipitation_cm = info["avg_precipitation_cm"].to_f
      @avg_snow_depth_cm    = info["avg_snow_depth_cm"].to_f
    end
    
    def sequence
      arr = super
      arr + ["@date", "@location", "@avg_high_temp_c", "@avg_low_temp_c", "@avg_wind_speed_kn", "@avg_precipitation_cm", "@avg_snow_depth_cm"]
    end
  end
end