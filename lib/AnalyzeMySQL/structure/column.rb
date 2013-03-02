module AnalyzeMySQL
  module Structure
    class Column
      def initialize(name, type, nullable, key, default, extra)
        @name = name
        @type = parse_type type
        @nullable = nullable == "NO" ? false : true
        @key = key
        @default = default
        @extra = extra
        @size = nil
        @max = nil
        @signed = nil
        @zerofill = nil
      end

      def parse_type(type)
        AnalyzeMySQL::Structure::Sizes::COL_TYPES.each do |coltype, infoset|
          pat_match = infoset[:pattern].match type
          unless pat_match == nil
            @type = coltype
            @size = infoset[:size] unless infoset[:size].nil?
            @max = infoset[:max] unless infoset[:max].nil?
            @zerofill = !AnalyzeMySQL::Structure::COL_ATTRS[:zerofill][:pattern].match(type).nil?
            @signed = AnalyzeMySQL::Structure::COL_ATTRS[:unsigned][:pattern].match(type).nil?
          end
        end
      end
    end
  end
end