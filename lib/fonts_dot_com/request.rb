require 'net/http'

module FontsDotCom
  class Request

    def self.fire(options)
      self.new(options).run
    end
   
    attr_accessor :request, 
                  :message, 
                  :method, 
                  :uri, 
                  :query_params, 
                  :data_params, 
                  :original_options
    
    def initialize(options={})
      set_up(options)
    end

    def set_up(options={})
      @original_options = options
      
      # Process options

      if options.is_a? String
        @message = options
      else
        @message      = options[:message]
        @method       = ( options[:method] || :get).to_sym
        @data_params  = options[:data]
        @query_params = options[:query]
      end

      raise ArgumentError unless allowed_http_verbs.include? @method



      @uri = URI(base + message)

      case method
      when :get
        @request = Net::HTTP::Get.new(uri)
      when :post
        @request = Net::HTTP::Post.new(uri)
      when :put
        @request = Net::HTTP::Put.new(uri)
      when :delete
        @request = Net::HTTP::Delete.new(uri)
      end
      
      # Compute md5 HMAC for request
      @auth_param = FontsDotCom::AuthParam.create @message
      
      # Set request headers
      @request['authorization'] = @auth_param
      @request['appKey'] = FontsDotCom::Config.app_key

      # Set form data
      @request.set_form_data(data_params) if data_params
      
      # Set query params 
      # TODO

      @request
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

    def allowed_http_verbs
      [:get, :post, :put, :delete]
    end
  end
end
