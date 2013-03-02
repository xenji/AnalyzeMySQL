require 'AnalyzeMySQL/version'
require 'AnalyzeMySQL/structure'
module AnalyzeMySQL
  def configure(params)

  end

  def exec(conf)
    conf['databases'].each do |db|
      acc = conf['access'][db]
      conn = Mysql2::Client.new(
          :host => acc['host'],
          :username => acc['user'],
          :password => acc['pass'],
          :port => acc['port'],
          :flags => Mysql2::Client::MULTI_STATEMENTS
      )

      # Do smth
    end
  end
end
