require 'net/http'

module FontsDotCom
  class Request

    def self.fire(options)
      self.new(options).run
    end
   
    attr_accessor :request, :message, :uri, :original_options
    
    def initialize(options={})
      set_up(options)
    end

    def set_up(options={})
      if options.is_a? String
        @message = options
      else
        @message = options[:message]
      end

      @original_options = options

      @uri = URI(base + message)

      @request = Net::HTTP::Get.new(uri)
      
      # Compute md5 HMAC for request
      @auth_param = FontsDotCom::AuthParam.create @message
      
      # Set request headers
      @request['authorization'] = @auth_param
      @request['appKey'] = FontsDotCom::Config.app_key
    end

    def run(attempted_authentication=false)
      res = Net::HTTP.start(uri.hostname, uri.port) {|http| http.request(@request) }

      @response = FontsDotCom::Response.new(res)

      return @response
    end

    private
    
    def base
      "#{protocol}://api.fonts.com"
    end
    
    def base_uri
      "#{protocol}://api.fonts.com/rest/#{format}/"
    end
    
    def config
      @config ||= FontsDotCom.config
    end

    def protocol
      'http' #TODO make settable?
    end
    
    def format
      'json' #TODO make settable?
    end
  end
end
