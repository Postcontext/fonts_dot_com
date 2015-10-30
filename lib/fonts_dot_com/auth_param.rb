require 'uri'
require 'openssl'
require 'base64'

module FontsDotCom
  class AuthParam
    # Returns properly-encoded md5 HMAC per
    # http://www.fonts.com/web-fonts/developers/api/authorizationparameter
   
    def self.create(message)
      self.new(message).compute
    end
  
    attr_accessor :message, :param
    
    def initialize(message)
      @message = message
    end

    def compute
      pub_key  = FontsDotCom::Config.public_key
      priv_key = FontsDotCom::Config.private_key

      #digest = OpenSSL::Digest::Digest.new('md5')
      digest = OpenSSL::Digest.new('md5')
      
      hash   = OpenSSL::HMAC.digest(digest, priv_key, "#{pub_key}|#{message}")
      hash64 = Base64.encode64(hash)
      auth   = "#{pub_key}:#{hash64}"
      
      @param = URI.encode(auth)
      
      return @param
    end
  end
end
