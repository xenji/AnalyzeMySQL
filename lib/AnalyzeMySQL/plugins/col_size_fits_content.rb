require 'AnalyzeMySQL/plugin/base'


class ColSizeFitsContent < AnalyzeMySQL::Plugin::Base
  def extract_my_config
    @myconfig = @config['settings']['col_size_fits_content']
  end

  def schema_ready(schema)
    extract_my_config
    @log.info 'Starting ColSizeFitsContent.'
    schema.tables.each do |tablename, table|
      @log.info "Processing #{tablename}"
      table.cols.each do |colname, col|
        @log.info "Processing #{tablename} > #{colname}"
        if @myconfig['scan'].include? col.type
          max = find_max_val tablename, colname, col.type
          max_allowed = col.size || col.max
          begin
            @log.debug "max(#{max})::max_allowed(#{max_allowed})::mangle(#{@myconfig['mangle']}%)"
            if max < (max_allowed / 100 * @myconfig['mangle'].to_i)
              report("Table: #{tablename} / Column: #{colname} :: maximum column content #{max} is " +
                         "below #{@myconfig['mangle']}% of it's max defined value of #{max_allowed}")
            end
          rescue Exception => e
            @log.error "Table: #{tablename} / Column: #{colname} error"
            @log.error col.inspect
            @log.error e
          end
        else
          @log.info "Skipping #{tablename} > #{colname} due coltype not in the config's scan[] array"
        end
      end
    end
  end

  def find_max_val(table, col, type)
    @conn.query("SELECT MAX(#{col}) as max FROM #{table}").each do |row|
      begin
        if type =~ /(char|text)/i
          if row['max'].nil?
            return 0
          end
          return row['max'].length
        else
          return row['max'].to_i
        end
      rescue Exception => e
        @log.error "Table: #{tablename} / Column: #{colname} error:", e
        raise e
      end
    end
  end

end