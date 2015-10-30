module FontsDotCom
  class Request

    def self.fire(options)
      self.new(options).run
    end
    
    def initialize(options={})
      set_up(options)
    end

    def set_up(options={})
      @original_options = options

      # TODO
      #
      #@request = Typhoeus::Request.new(
      #  base_uri,
      #  method: :post,
      #  body: @request_params
      #)
    end

    def run(attempted_authentication=false)
      #maybe_say "about to 'run' this request: \n#{request.inspect}\n"

      res = request.run

      # TODO
      #@response = FontsDotCom::Response.new(res)
      @response = res

      #maybe_say "response body:"
      #maybe_say response.body

      return @response
    end

    private

    def format_bulk_params(options)
      requests = options.fetch(:requests)
      requests = requests.to_json unless requests.is_a? String

      {
        sessionKey:   session_key,
        clientCode:   config[:clientCode],
        requests:     requests 
      }
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
