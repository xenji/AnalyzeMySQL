module AnalyzeMySQL
  module Structure
    class Column
      attr_reader :name, :nullable, :default, :extra, :size, :sized, :max, :signed,:zerofill, :type
      def initialize(name, type, nullable, key, default, extra)
        @name = name
        @nullable = nullable == "NO" ? false : true
        @key = key
        @default = default
        @extra = extra
        @size = nil
        @max = nil
        @signed = nil
        @zerofill = nil
        parse_type type
      end

      def parse_type(type)
        AnalyzeMySQL::Structure::Sizes::COL_TYPES.each do |coltype, infoset|
          pat_match = infoset[:pattern].match type
          unless pat_match == nil
            @type = coltype.to_s
            @sized = infoset[:sized] unless infoset[:sized].nil?
            @max = infoset[:max] unless infoset[:max].nil?
            @zerofill = !AnalyzeMySQL::Structure::Sizes::COL_ATTRS[:zerofill][:pattern].match(type).nil?
            @signed = AnalyzeMySQL::Structure::Sizes::COL_ATTRS[:unsigned][:pattern].match(type).nil?
            @size = pat_match[1].to_i if @sized

            unless @sized or @max
              @size = @signed ? infoset[:signed_hi] : infoset[:unsigned]
            end
            return
          end
        end
      end
    end
  end
end