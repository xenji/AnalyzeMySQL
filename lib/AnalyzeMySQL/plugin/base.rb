require 'plugman/plugin_base'
require 'logger'

module AnalyzeMySQL
  module Plugin
    class Base < Plugman::PluginBase
      def configure!(config, conn)
        @config = config
        @conn = conn
        @log = ::Logger.new(STDOUT)
        @output = []
      end

      def report(line)
        @output << line.to_s
      end

      def contribute_report(report_pool)
        report_pool << @output
      end
    end
  end
end
