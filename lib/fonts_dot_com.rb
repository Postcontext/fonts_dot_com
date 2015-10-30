require "fonts_dot_com/version"
require "fonts_dot_com/config"
require "fonts_dot_com/auth_param"
require "fonts_dot_com/request"
require "fonts_dot_com/response"

module FontsDotCom

  class << self

    ##
    #
    # Projects
    #
    ##
    
    # http://www.fonts.com/web-fonts/developers/api/list-projects
    def list_projects
      FontsDotCom::Request.fire({
        message:  '/rest/json/Projects/', # TODO 
        method:   :get
      })
    end

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
   
    # http://www.fonts.com/web-fonts/developers/api/delete-project
    def delete_project(project_id)
      raise ArgumentError unless project_id
      
      data = {
        wfsproject_name: name
      }
      
      response = FontsDotCom::Request.fire({
        message:  "/rest/json/Projects/?wfspid=#{project_id}",
        method:   :delete
      })
    end



    ###
    # 
    # Project Fonts
    #
    ###

    def list_project_fonts(project_id)
      # `project_id` should be fonts.com's project ID (returned as
      # `ProjectKey` by the API.)
      raise ArgumentError unless project_id
      
      response = FontsDotCom::Request.fire({
        message:  "/rest/json/Fonts/?wfspid=#{project_id}",
        method:   :get
      })
    end

  end

end
