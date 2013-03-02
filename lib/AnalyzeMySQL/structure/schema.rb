require 'colorize'
module AnalyzeMySQL
  module Structure
    class Schema
      attr_reader :tables

      def initialize(conn, conf, name)
        @name = name
        @conn = conn
        @conf = conf
        @tables = {}
        refresh_cache
      end

      def refresh_cache
        @conn.query("USE #@name")
        @conn.query('SHOW TABLES').each do |v|
          table = v.first[1]
          @tables[table] = AnalyzeMySQL::Structure::Table.new(@conn, @conf, table) if table_included? table
        end
      end

      def table_included?(table)
        has_all = !@conf['tables']['include'].nil? and @conf['tables']['include'].include? 'all'
        has_excludes = !@conf['tables']['exclude'].nil?
        use_all = (has_all and !has_excludes)

        if has_all and !@conf['tables']['exclude'].nil? and !@conf['tables']['exclude'].include? table
          puts "Table #{table} is included in `all` and not excluded. Using it.".light_green
          return true
        end

        if !has_all and !@conf['tables']['include'].include? table
          puts "Table #{table} is not included in the includes-list. Skipping it.".light_yellow
          return false
        end
        if use_all
          puts 'All tables included, messages per table will be skipped.'.light_green if use_all
          return true
        end

        # Raise exception?
        puts "No matches at all for table #{table}, this might be an error.".red
        false
      end
    end
  end
end