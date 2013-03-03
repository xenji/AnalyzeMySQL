require 'AnalyzeMySQL/version'
require 'AnalyzeMySQL/structure'
require 'yaml'
require 'mysql2'

module AnalyzeMySQL
  def self.conf(params)
    conf = YAML.load_file params[:config]

    unless conf['plugin_paths'].nil?
      conf['plugin_paths'].each do |dir|
        dir = dir[0] == '/' ? dir : File.expand_path(dir, Dir.getwd)
        $LOAD_PATH.unshift(dir) unless $LOAD_PATH.include? dir
      end
    end

    unless conf['active_analytics'].nil?
      conf['active_analytics'].each do |file|
        require file + '.rb'
      end
    end

    conf
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

      puts s.tables['foo'].cols.inspect
    end
  end
end
