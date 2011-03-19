module TripIt
  class PointsProgram < Base
    attr_reader :id, :name, :account_number, :account_login, :balance, :elite_status, :elite_next_status, :elite_ytd_qualify, :elite_need_to_earn, \
                :error_message, :last_modified, :total_num_activities, :total_num_expirations, :activity, :expiration
    
    def initialize(params = {})
      raise ArgumentError, "PointsProgram created with empty parameters" if params.empty?
      
      @id                     = params["id"]
      @name                   = params["name"]
      @account_number         = params["account_number"]
      @account_login          = params["account_login"]
      @balance                = params["balance"]
      @elite_status           = params["elite_status"]
      @elite_next_status      = params["elite_next_status"]
      @elite_ytd_qualify      = params["elite_ytd_qualify"]
      @elite_need_to_earn     = params["elite_need_to_earn"]
      @error_message          = params["error_message"]
      @last_modified          = params["last_modified"]
      @total_num_activities   = params["total_num_activities"]
      @total_num_expirations  = params["total_num_expirations"]
      @activity               = []
      @expiration             = []
      chkAndPopulate(@activity, TripIt::PointsProgramActivity, params["Activity"]) unless params["Activity"].nil?
      chkAndPopulate(@expiration, TripIt::PointsProgramExpiration, params["Expiration"]) unless params["Expiration"].nil?
    end
  end
end