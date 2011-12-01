module TripIt
  class Profile < Base
    attr_reader :profile_email_addresses, :group_memberships, :screen_name, :public_display_name, :profile_url, :home_city, :company, \
                :about_me_info, :photo_url, :activity_feed_url, :alerts_feed_url, :ical_url, :ref
    boolean_read_param :is_pro, :is_client
    
    def initialize(client, source = nil)
      @client = client
      @tripCache ||= {}
      populate(source)
    end
    
    def populate(source)
      info = source || @client.get("/profile")["Profile"]
      
      @screen_name              = info['screen_name']
      @public_display_name      = info['public_display_name']
      @profile_url              = info['profile_url']
      @home_city                = info['home_city']
      @company                  = info['company']
      @about_me_info            = info['about_me_info']
      @photo_url                = info['photo_url']
      @activity_feed_url        = info['activity_feed_url']
      @alerts_feed_url          = info['alerts_feed_url']
      @is_pro                   = Boolean(info['is_pro'])
      @is_client                = Boolean(info['is_client'])
      @ical_url                 = info['ical_url']
      @ref                      = info['@attributes']['ref']
      @profile_email_addresses  = []
      @group_memberships        = []
      
      chkAndPopulate(@profile_email_addresses, TripIt::ProfileEmailAddress, info['ProfileEmailAddresses']['ProfileEmailAddress']) unless info['ProfileEmailAddresses'].nil?
      chkAndPopulate(@group_memberships, TripIt::Group, info['GroupMemberships']['Group']) unless info['GroupMemberships'].nil?
    end
    
    def trips(params = {})
      serialized_param_str = params.keys.sort.inject('') do |str, key| str += "#{key}:#{params[key]}::" end
      return @tripCache[serialized_param_str] unless @tripCache[serialized_param_str].nil?
      tripArr = []
      tripList = @client.list("/trip", params)["Trip"]
      unless tripList.nil?
        if tripList.is_a?(Array)
          tripList.each do |trip|
            tripArr << TripIt::Trip.new(@client,trip['id'],params[:include_objects])
          end
        else
          tripArr << TripIt::Trip.new(@client,tripList['id'],params[:include_objects])
        end
      end
      @tripCache[serialized_param_str] = tripArr
      return tripArr
    end
    
    def points_programs
      return [] if self.is_pro == false
      return @progArr unless @progArr.nil?
      @progArr = []
      progList = @client.list("/points_program")["PointsProgram"]
      unless progList.nil?
        if progList.is_a?(Array)
          progList.each do |prog|
            @progArr << TripIt::PointsProgram.new(prog)
          end
        else
          @progArr << TripIt::PointsProgram.new(progList)
        end
      end
      return @progArr
    end
    
    def subscribe_trips
      @client.subscribe("/trip")
    end
    
    def unsubscribe
      @client.unsubscribe
    end
  end
end
