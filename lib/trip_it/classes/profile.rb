module TripIt
  class Profile < Base
    attr_reader :profile_email_addresses, :group_memberships, :is_client, :is_pro, :screen_name, :public_display_name, :profile_url, :home_city, :company, \
                :about_me_info, :photo_url, :activity_feed_url, :alerts_feed_url, :ical_url, :ref
                
    def initialize(client, source = nil)
      @client = client
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
      
      checkForArray(@profile_email_addresses, TripIt::ProfileEmailAddress, info['ProfileEmailAddresses']['ProfileEmailAddress']) unless info['ProfileEmailAddresses'].nil?
      checkForArray(@group_memberships, TripIt::Group, info['GroupMemberships']['Group']) unless info['GroupMemberships'].nil?
    end
    
    def trips(params = {})
      return @tripArr unless @tripArr.nil?
      @tripArr = []
      tripList = @client.list("/trip", params)["Trip"]
      if tripList.is_a?(Array)
        tripList.each do |trip|
          @tripArr << TripIt::Trip.new(@client,trip['id'],params[:include_objects])
        end
      else
        @tripArr << TripIt::Trip.new(@client,tripList['id'],params[:include_objects])
      end
      return @tripArr
    end
    
    def points_programs
      return [] if self.is_pro == false
      return @progArr unless @progArr.nil?
      @progArr = []
      progList = @client.list("/points_program")["PointsProgram"]
      if progList.is_a?(Array)
        progList.each do |prog|
          @progArr << TripIt::PointsProgram.new(prog)
        end
      else
        @progArr << TripIt::PointsProgram.new(progList)
      end
      return @progArr
    end
  end
end