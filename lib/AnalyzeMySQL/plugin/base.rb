require 'plugman/plugin_base'

module AnalyzeMySQL
  module Plugin
    class Base <  Plugman::PluginBase
    def configure!(config, conn)
        @config = config
        @conn = conn
        @activated = false
      end

      def enable!
        @activated = true
      end

      def disable!
        @activated = false
      end

      def active?
        @activated
      end
    end
  end
end
