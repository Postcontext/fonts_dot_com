require 'yaml'

module FontsDotCom
  module Config

    class << self
     
      attr_accessor :public_key, :private_key, :api_key
      
      def configure
        yield self
      end

      def app_key
        api_key
      end
    end
  end
end
