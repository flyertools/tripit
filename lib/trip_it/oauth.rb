module TripIt
  class OAuth < Base
    attr_reader :consumer, :access_token
    exceptions :bad_request_exception, :unauthorized_exception, :not_found_exception, :server_error
    
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
      returnResponse(request)
    end
    
    def list(resource, params={})
      params.merge!(:format => "json")
      params_string = params.collect{|k, v| "#{k}/#{v}"}.join('/')
      request = access_token.get("/v1/list#{resource}/#{URI.escape(params_string)}")
      returnResponse(request)
    end
    
    def create(params={})
      params.merge!(:format => "json")
      params.each {|k, v| params[k] = v.join(', ') if v.is_a?(Array)}
      request = access_token.post("/v1/create", params)
      returnResponse(request)
    end
    
    def replace(resource, params={})
      params.merge!(:format => "json")
      params.each {|k, v| params[k] = v.join(', ') if v.is_a?(Array)}
      request = access_token.post("/v1/replace#{resource}", params)
      returnResponse(request)
    end        
    
    def delete(resource, params={})
      params.merge!(:format => "json")
      params_string = params.collect{|k, v| "#{k}/#{v}"}.join('/')
      request = access_token.get("/v1/delete#{resource}/#{URI.escape(params_string)}")
      returnResponse(request)
    end
    
    def returnResponse(request)
      case request
      when Net::HTTPOK: return JSON.parse(request.body)
      when Net::HTTPBadRequest: raise BadRequestException, request.body
      when Net::HTTPUnauthorized: raise UnauthorizedException, request.body
      when Net::HTTPNotFound: raise NotFoundException, request.body
      when Net::HTTPInternalServerError: raise ServerError, request.body
      end
    end
  end
end