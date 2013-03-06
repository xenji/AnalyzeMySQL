require 'AnalyzeMySQL/version'
require 'AnalyzeMySQL/structure'
require 'AnalyzeMySQL/report/pool'
require 'yaml'
require 'mysql2'
require 'plugman'
require 'logger'

module AnalyzeMySQL
  class App
    def conf(params)
      conf = YAML.load_file params[:config]

      unless conf['plugin_paths'].nil?
        @plugins = Plugman.new(loader: Plugman::ConfigLoader.new(conf['plugin_paths']))
        @plugins.load_plugins
      end
      conf
    end

    def run(conf)
      conf['databases'].each do |db|
        acc = conf['access'][db]
        conn = Mysql2::Client.new(
            :host => acc['host'],
            :username => acc['user'],
            :password => acc['pass'],
            :port => acc['port'],
            :flags => Mysql2::Client::MULTI_STATEMENTS
        )

        schema = AnalyzeMySQL::Structure::Schema.new(conn, conf, db)
        @plugins.notify(:configure!, conf, conn)
        @plugins.notify(:schema_ready, schema)

        rpool = AnalyzeMySQL::Report::Pool.new
        @plugins.notify(:contribute_report, rpool)

        # This is very simple, but enough to test it.
        # In the future we should notify output plugins here
        log = ::Logger.new(STDOUT)
        rpool.report.each do |msg|
          log.warn msg
        end
      end
    end
  end
end