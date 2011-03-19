module TripIt
  class Trip < Base
    attr_reader :closeness_matches, :trip_invitees, :trip_crs_remarks, :id, :relative_url, :info
    date_param :start_date, :end_date
    string_param :description, :display_name, :image_url, :primary_location
    boolean_param :is_private
    exceptions :not_implemented_error
    
    def initialize(client, obj_id = nil, include_children = false, source = nil)
      @client = client
      # If we get an Object ID, we'll load and populate it. Otherwise assume its a new Trip Object.
      unless obj_id.nil?
        @obj_id = obj_id
        include_children ? populate(source, :include_objects => true) : populate(source)
      end
    end
    
    def populate(source, params = {})
      params.merge!( {:id => @obj_id} )
      info = source || @client.get("/trip", params)
            
      @id                         = info['Trip']['id']
      @primary_location           = info['Trip']['primary_location']
      @is_private                 = Boolean(info['Trip']['is_private'])
      @display_name               = info['Trip']['display_name']
      @description                = info['Trip']['description']
      @start_date                 = Date.parse(info['Trip']['start_date'])
      @end_date                   = Date.parse(info['Trip']['end_date'])
      @image_url                  = info['Trip']['image_url']
      @relative_url               = info['Trip']['relative_url']
      @trip_crs_remarks           = []
      @trip_invitees              = []
      @closeness_matches          = []
      
      chkAndPopulate(@trip_crs_remarks, TripIt::TripCrsRemark, info['Trip']['TripCrsRemarks']['TripCrsRemark']) unless info['Trip']['TripCrsRemarks'].nil?
      
      # Load associated profiles into Profile objects
      profileInfo                 = info['Profile']
      profiles                    = []
      if profileInfo.is_a?(Array)
        profileInfo.each do |pi|
          profiles << TripIt::Profile.new(@client, pi)
        end
      else
        profiles << TripIt::Profile.new(@client, profileInfo)
      end
      # And now match them into the invitees and closenessmatches array
      unless info['Trip']['ClosenessMatches'].nil?
        if info['Trip']['ClosenessMatches']['Match'].is_a?(Array)
          info['Trip']['ClosenessMatches']['Match'].each do |match|
            @closeness_matches << profiles.find { |profile| profile.ref == match['@attributes']['profile_ref'] }
          end
        else
          @closeness_matches << profiles.find { |profile| profile.ref == info['Trip']['ClosenessMatches']['Match']['@attributes']['profile_ref'] }
        end
      end
      
      unless info['Trip']['TripInvitees'].nil?
        if info['Trip']['TripInvitees']['Invitee'].is_a?(Array)
          info['Trip']['TripInvitees']['Invitee'].each do |invitee|
            @trip_invitees << TripIt::Invitee.new(invitee, profiles.find { |profile| profile.ref == invitee['@attributes']['profile_ref'] })
          end
        else
          @trip_invitees << TripIt::Invitee.new(info['Trip']['TripInvitees']['Invitee'], profiles.find { |profile| profile.ref == info['Trip']['TripInvitees']['Invitee']['@attributes']['profile_ref'] })
        end
      end
      
      # If include_objects is true, we need to fill them up here
      if params[:include_objects] == true
        [
          [info['ActivityObject'], @activities = [], TripIt::ActivityObject],
          [info['AirObject'], @air = [], TripIt::AirObject],
          [info['CarObject'], @cars = [], TripIt::CarObject],
          [info['CruiseObject'], @cruises = [], TripIt::CruiseObject],
          [info['DirectionsObject'], @directions = [], TripIt::DirectionsObject],
          [info['LodgingObject'], @lodgings = [], TripIt::LodgingObject],
          [info['MapObject'], @maps = [], TripIt::MapObject],
          [info['NoteObject'], @notes = [], TripIt::NoteObject],
          [info['RailObject'], @rail = [], TripIt::RailObject],
          [info['RestaurantObject'], @restaurants = [], TripIt::RestaurantObject],
          [info['TransportObject'], @transports = [], TripIt::TransportObject],
          [info['WeatherObject'], @weather = [], TripIt::WeatherObject]
        ].each do |obj|
          unless obj[0].nil?
            chkObjAndPopulate(@client, obj[1], obj[2], obj[0])
          end
        end
      end
    end
    
    def activities
      return @activities unless @activities.nil?
      actobj = @client.list("/object", {:trip_id => @id, :type => "activity"})["ActivityObject"]
      @activities = []
      return @activities if actobj.nil?
      chkObjAndPopulate(@client, @activities, TripIt::ActivityObject, actobj)
      return @activities
    end
    
    def air
      return @air unless @air.nil?
      airobj = @client.list("/object", {:trip_id => @id, :type => "air"})["AirObject"]
      @air = []
      return @air if airobj.nil?
      chkObjAndPopulate(@client, @air, TripIt::AirObject, airobj)
      return @air
    end
    
    def cars
      return @cars unless @cars.nil?
      carobj = @client.list("/object", {:trip_id => @id, :type => "car"})["CarObject"]
      @cars = []
      return @cars if carobj.nil?
      chkObjAndPopulate(@client, @cars, TripIt::CarObject, carobj)
      return @cars
    end
    
    def cruises
      return @cruises unless @cruises.nil?
      cruiseobj = @client.list("/object", {:trip_id => @id, :type => "cruise"})["CruiseObject"]
      @cruises = []
      return @cruises if cruiseobj.nil?
      chkObjAndPopulate(@client, @cruises, TripIt::CruiseObject, cruiseobj)
      return @cruises
    end
    
    def directions
      return @directions unless @directions.nil?
      directobj = @client.list("/object", {:trip_id => @id, :type => "directions"})["DirectionsObject"]
      @directions = []
      return @directions if directobj.nil?
      chkObjAndPopulate(@client, @directions, TripIt::DirectionsObject, directobj)
      return @directions
    end
    
    def lodgings
      return @lodgings unless @lodgings.nil?
      lodgingobj = @client.list("/object", {:trip_id => @id, :type => "lodging"})["LodgingObject"]
      @lodgings = []
      return @lodgings if lodgingobj.nil?
      chkObjAndPopulate(@client, @lodgings, TripIt::LodgingObject, lodgingobj)
      return @lodgings
    end
    
    def maps
      return @maps unless @maps.nil?
      mapsobj = @client.list("/object", {:trip_id => @id, :type => "map"})["MapObject"]
      @maps = []
      return @maps if mapsobj.nil?
      chkObjAndPopulate(@client, @maps, TripIt::MapObject, mapsobj)
      return @maps
    end
    
    def notes
      return @notes unless @notes.nil?
      noteobj = @client.list("/object", {:trip_id => @id, :type => "note"})["NoteObject"]
      @notes = []
      return @notes if noteobj.nil?
      chkObjAndPopulate(@client, @notes, TripIt::NoteObject, noteobj)
      return @notes   
    end
    
    def rail
      return @rail unless @rail.nil?
      railobj = @client.list("/object", {:trip_id => @id, :type => "rail"})["RailObject"]
      @rail = []
      return @rail if railobj.nil?
      chkObjAndPopulate(@client, @rail, TripIt::RailObject, railobj)
      return @rail
    end
    
    def restaurants
      return @restaurants unless @restaurants.nil?
      restobj = @client.list("/object", {:trip_id => @id, :type => "restaurant"})["RestaurantObject"]
      @restaurants = []
      return @rail if restobj.nil?
      chkObjAndPopulate(@client, @restaurants, TripIt::RestaurantObject, restobj)
      return @restaurants
    end
    
    def transports
      return @transports unless @transports.nil?
      transobj = @client.list("/object", {:trip_id => @id, :type => "transport"})["TransportObject"]
      @transports = []
      return @transports if transobj.nil?
      chkObjAndPopulate(@client, @transports, TripIt::TransportObject, transobj)
      return @transports
    end
    
    def weather
      return @weather unless @weather.nil?
      wxobj = @client.list("/object", {:trip_id => @id, :type => "weather"})["WeatherObject"]
      @weather = []
      return @weather if wxobj.nil?
      chkObjAndPopulate(@client, @weather, TripIt::WeatherObject, wxobj)
      return @weather      
    end
    
    def sequence
      ["@start_date", "@end_date", "@description", "@display_name","@image_url", "@is_private", "@primary_location"]
    end
    
    def save
      [ @activities,
        @air,
        @cars,
        @cruises,
        @directions,
        @lodgings,
        @maps,
        @notes,
        @rail,
        @restaurants,
        @transports,
        @weather
      ].each do |obj|
          unless obj.nil?
            if obj.count > 1
              raise NotImplementedError, "Can only save one complex object at a time"
            end
          end
        end
        
        # We only want to allow save for new objects for now.
        if @obj_id.nil?
          @client.create(self.xml)
        end
    end
    
    def timeline
      [
        @activities,
        @cars,
        @directions,
        @lodgings,
        @maps,
        @notes,
        @restaurants
      ].each do |obj|
        unless obj.empty?
          if !obj.first.start_date_time.nil?
            # Sort by Start_Date_Time
          elsif !obj.first.datetime.nil?
            # Sort by datetime
          end
        end
      end
    end
  end
end