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
      end

      def parse_type(type)

      end
    end
  end
end