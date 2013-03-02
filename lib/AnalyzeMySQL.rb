require 'AnalyzeMySQL/version'
require 'AnalyzeMySQL/structure'
require 'yaml'
require 'mysql2'

module AnalyzeMySQL
  def self.conf(params)
    YAML.load_file params[:config]
  end

  def self.run(conf)
    conf['databases'].each do |db|
      acc = conf['access'][db]
      conn = Mysql2::Client.new(
          :host => acc['host'],
          :username => acc['user'],
          :password => acc['pass'],
          :port => acc['port'],
          :flags => Mysql2::Client::MULTI_STATEMENTS
      )

      s = AnalyzeMySQL::Structure::Schema.new(conn, conf, db)

    end
  end
end
