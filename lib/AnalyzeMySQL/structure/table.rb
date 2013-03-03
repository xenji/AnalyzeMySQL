module AnalyzeMySQL
  module Structure
    class Table
      attr_reader :cols, :meta

      def initialize(conn, conf, name)
        @name = name
        @conn = conn
        @conf = conf
        @cols = {}
        @meta = {}
        @keys = {
            :primary => {},
            :unique => {},
            :fulltext => {}, # only MyISAM
            :index => {}
        }
        refresh_cache
      end

      def refresh_cache
        meta_definition
        col_definition
        #index_definition
      end

      def meta_definition
        @conn.query("SHOW TABLE STATUS LIKE '#@name'").each do |row|
          @meta[:engine] = row['Engine']
          @meta[:version] = row['Version']
          @meta[:row_format] = row['Row_format']
          @meta[:rows] = row['Rows']
          @meta[:avg_row_length] = row['Avg_row_length']
          @meta[:data_length] = row['Data_length']
          @meta[:max_data_length] = row['Max_data_length']
          @meta[:index_length] = row['Index_length']
          @meta[:data_free] = row['Data_free']
          @meta[:auto_increment] = row['Auto_increment']
          @meta[:create_time] = row['Create_time']
          @meta[:update_time] = row['Update_time']
          @meta[:check_time] = row['Check_time']
          @meta[:collation] = row['Collation']
          @meta[:create_options] = row['Create_options']
          @meta[:comment] = row['Comment']
        end
      end

      def col_definition
        @conn.query("DESCRIBE #@name").each do |row|
          @cols[row['Field']] = AnalyzeMySQL::Structure::Column.new(
              row['Field'], row['Type'], row['Null'],
              row['Key'], row['Default'], row['Extra']
          )
        end
      end

      def index_definition
        @conn.query("SHOW INDEX FROM #@name").each do |row|

        end
      end
    end
  end
end