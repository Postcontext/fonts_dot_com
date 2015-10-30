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
  
    attr_accessor :message, :param, :digest, :hasher, :concatenation, :hash, :hash64, :auth
    
    def initialize(message)
      @message = message
      @digest = OpenSSL::Digest.new('md5')
      @hasher = OpenSSL::HMAC.new(priv_key, @digest)
      @concatenation = "#{pub_key}|#{message}"
    end

    def compute
      hasher.update(concatenation)
      @hash = hasher.to_s
      
      # Convert hash from hex to base 64
      @hash64 = [[@hash].pack("H*")].pack("m0")
      @auth   = "#{pub_key}:#{@hash64}"
      @param  = URI.encode(@auth)
      
      return @param
    end

    def pub_key
      pub_key = FontsDotCom::Config.public_key
    end

    def priv_key
      priv_key = FontsDotCom::Config.private_key
    end
  end
end
