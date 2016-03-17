require "fonts_dot_com/version"
require "fonts_dot_com/config"
require "fonts_dot_com/auth_param"
require "fonts_dot_com/request"
require "fonts_dot_com/response"
require "fonts_dot_com/api"

module FontsDotCom

  class << self
    def configure(&block)
      FontsDotCom::Config.configure(&block)
    end
  end

end
