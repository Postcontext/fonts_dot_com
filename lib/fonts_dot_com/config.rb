require 'yaml'

module FontsDotCom
  module Config
    
    CONFIG = YAML.load_file('../../config/fonts_dot_com.yml')

    class << self
      def public_key
        @public_key ||= CONFIG['public_key']
      end

      def private_key
        @private_key ||= CONFIG['private_key']
      end

      def api_key
        @api_key ||= CONFIG['api_key']
      end

      def app_key
        api_key
      end
    end
  end
end
