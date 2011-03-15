module TripIt
  class OAuth
    attr_reader :consumer, :access_token
    
    def initialize(ctoken, csecret)
      @consumer = ::OAuth::Consumer.new(ctoken, csecret, :site => 'https://api.tripit.com')
    end
    
    def set_callback_url(url)
      @request_token = nil
      request_token(:oauth_callback => url)
    end
    
    def request_token(options={})
      @request_token ||= consumer.get_request_token(options)
    end
    
    def authorize_from_request(rtoken, rsecret, verifier)
      request_token = ::OAuth::RequestToken.new(consumer, rtoken, rsecret)
      access = request_token.get_access_token(:oauth_verifier => verifier)
      @access_token = ::OAuth::AccessToken.new(consumer, access.token, access.secret)
    end
    
    def authorize_from_access(atoken, asecret)
      @access_token = ::OAuth::AccessToken.new(consumer, atoken, asecret)
    end
    
    def get(resource, params={})
      params.merge!(:format => "json")
      params_string = params.collect{|k, v| "#{k}/#{v}"}.join('/')
      request = access_token.get("/v1/get#{resource}/#{URI.escape(params_string)}")
      JSON.parse(request.body)
    end
    
    def list(resource, params={})
      params.merge!(:format => "json")
      params_string = params.collect{|k, v| "#{k}/#{v}"}.join('/')
      request = access_token.get("/v1/list#{resource}/#{URI.escape(params_string)}")
      JSON.parse(request.body)
    end
    
    def create(params={})
      params.merge!(:format => "json")
      params.each {|k, v| params[k] = v.join(', ') if v.is_a?(Array)}
      request = access_token.post("/v1/create", params)
      JSON.parse(request.body)
    end
    
    def replace(resource, params={})
      params.merge!(:format => "json")
      params.each {|k, v| params[k] = v.join(', ') if v.is_a?(Array)}
      request = access_token.post("/v1/replace#{resource}", params)
      JSON.parse(request.body)
    end        
    
    def delete(resource, params={})
      params.merge!(:format => "json")
      params_string = params.collect{|k, v| "#{k}/#{v}"}.join('/')
      request = access_token.get("/v1/delete#{resource}/#{URI.escape(params_string)}")
      JSON.parse(request.body)
    end
  end
end