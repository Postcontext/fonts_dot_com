require "fonts_dot_com/version"
require "fonts_dot_com/config"
require "fonts_dot_com/auth_param"
require "fonts_dot_com/request"
require "fonts_dot_com/response"

module FontsDotCom

  class << self

    # Such convenience

    # http://www.fonts.com/web-fonts/developers/api/add-project
    def add_project(name)
      unless ( name.is_a? String ) && ( name.length > 0 )
        raise ArgumentError
      end
      
      data = {
        wfsproject_name: name
      }
      
      response = FontsDotCom::Request.fire({
        message:  '/rest/json/Projects/', # TODO 
        method:   :post,
        data:     data
      })
    end

  end

end
