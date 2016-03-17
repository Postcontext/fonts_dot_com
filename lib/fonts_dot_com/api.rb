module FontsDotCom
  class Api
    class << self

      ##
      #
      # Projects
      #
      ##
      
      # http://www.fonts.com/web-fonts/developers/api/list-projects
      def list_projects(options={})
        base_path = '/rest/json/Projects/'
        limit     = options[:limit]  || 10
        offset    = options[:offset] || 0
      
        path = "#{base_path}?wfsplimit=#{limit}&wfspstart=#{offset}"

        puts "path is: #{path}"

        args = options.merge({
          message:  path,
          method:   :get
        })

        FontsDotCom::Request.fire(args)
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
          message:  '/rest/json/Projects/',
          method:   :post,
          data:     data
        })
      end
   
      # http://www.fonts.com/web-fonts/developers/api/delete-project
      def delete_project(project_id)
        raise ArgumentError unless project_id
        
        response = FontsDotCom::Request.fire({
          message:  "/rest/json/Projects/?wfspid=#{project_id}",
          method:   :delete
        })
      end
      
      
      
      ##
      #
      # Stylesheets
      #
      ##
      
      # https://www.fonts.com/web-fonts/developers/api/export
      def export_stylesheet(project_id)
        base_path = '/rest/json/ProjectStylesExport/'
        path      = "#{base_path}?wfspid=#{project_id}"
        
        FontsDotCom::Request.fire({
          message:  path,
          method:   :get
        })
      end

      # https://www.fonts.com/web-fonts/developers/api/import
      def import_stylesheet(project_id, project_token)
        # NOTE: get `ProjectToken` from #export_stylesheet
        #   `project_id` is the ID of the recipient project
        #   `project_token` is the token from the project whose
        #     stylesheet is being imported

        base_path = '/rest/json/ProjectStylesExport/'
        path      = "#{base_path}?wfspid=#{project_id}&wfsptoken=#{project_token}"
        
        FontsDotCom::Request.fire({
          message:  path,
          method:   :get
        })
      end

      # https://www.fonts.com/web-fonts/developers/api/add-stylesheet
      def add_stylesheet
      end




      ###
      # 
      # Project Fonts
      #
      ###

      def list_project_fonts(project_id, options={})
        # `project_id` should be fonts.com's project ID (returned as
        # `ProjectKey` by the API.)
        raise ArgumentError unless project_id
        
        offset_and_limit = ''
        if options[:offset] 
          offset_and_limit += ( '&wfspstart=' + options[:offset].to_s )
        end
        if options[:limit]
          offset_and_limit += ( '&wfsplimit=' + options[:limit].to_s )
        end

        response = FontsDotCom::Request.fire({
          message:  "/rest/json/Fonts/?wfspid=#{project_id}#{offset_and_limit}",
          method:   :get
        })
      end
      
      def add_font(options)
        project_id  = options[:project_id]
        font_id     = options[:font_id]
        publish     = options.has_key?(:publish) ? options[:publish] : true

        raise ArgumentError unless project_id && font_id
        
        data = {
          wfsfid: font_id
        }

        response = FontsDotCom::Request.fire({
          message:  "/rest/json/Fonts/?wfspid=#{project_id}",
          method:   :post,
          data:     data
        })
      end
      
      
      
      ###
      # 
      # Selectors
      #
      ###

      # https://www.fonts.com/web-fonts/developers/api/list-selectors
      def list_selectors(project_id, options={})
        # `project_id` should be fonts.com's project ID (returned as
        # `ProjectKey` by the API.)
        raise ArgumentError unless project_id
        
        offset_and_limit = ''
        if options[:offset] 
          offset_and_limit += ( '&wfspstart=' + options[:offset].to_s )
        end
        if options[:limit]
          offset_and_limit += ( '&wfsplimit=' + options[:limit].to_s )
        end

        response = FontsDotCom::Request.fire({
          message:  "/rest/json/Selectors/?wfspid=#{project_id}#{offset_and_limit}",
          method:   :get
        })
      end
      
      
      ###
      # 
      # Domains
      #
      ###

      # https://www.fonts.com/web-fonts/developers/api/list-domains
      def list_domains(project_id, options={})
        # `project_id` should be fonts.com's project ID (returned as
        # `ProjectKey` by the API.)
        raise ArgumentError unless project_id
        
        offset_and_limit = ''
        if options[:offset] 
          offset_and_limit += ( '&wfspstart=' + options[:offset].to_s )
        end
        if options[:limit]
          offset_and_limit += ( '&wfsplimit=' + options[:limit].to_s )
        end

        response = FontsDotCom::Request.fire({
          message:  "/rest/json/Domains/?wfspid=#{project_id}#{offset_and_limit}",
          method:   :get
        })
      end
   
      # https://www.fonts.com/web-fonts/developers/api/add-domain
      def add_domain(options)
        project_id  = options[:project_id]
        domain_name = options[:domain_name]
        publish     = options.has_key?(:publish) ? options[:publish] : true

        raise ArgumentError unless project_id && domain_name
        
        path  = "/rest/json/Domains/?wfspid=#{project_id}"
        #path += '&wfsnopublish=1' unless publish
        
        data = {
          wfsdomain_name: domain_name
        }

        response = FontsDotCom::Request.fire({
          message:  path,
          method:   :post,
          data:     data
        })
      end
      
      
      
      ###
      # 
      # Publish
      #
      ###

      # https://www.fonts.com/web-fonts/developers/api/publish
      def publish
        response = FontsDotCom::Request.fire({
          message:  "/rest/json/Publish/",
          method:   :get
        })
      end




















    end
  end
end
