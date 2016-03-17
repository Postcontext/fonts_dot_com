require 'json'

module FontsDotCom
  class Response

    class ApiError < StandardError 
      attr :response
      
      def initialize(response)
        @response = response
      end

      class AuthenticationFailed; end
    end

    attr_accessor :original_response_object, :body, :code

    def initialize(response, options={})
      @original_response_object = response

      json  = JSON.parse(response.body)

      @body = json
      @code = response.code

      raise error.new(self) if returned_error
    end

    def status
      raise 'TODO'
    end

    def session_key
      records[0].fetch(:sessionKey) 
    end

    def returned_error
      code[0].to_i > 2
    end

    def error
      # TODO
      ApiError
    end

    private

    def authentication_error_code
      raise 'todo'
    end
  end
end
