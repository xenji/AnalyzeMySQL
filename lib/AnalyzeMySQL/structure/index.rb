module AnalyzeMySQL
  module Structure
    class Index
      def initialize(name, unique, sequence_in_idx, colname, collation, cardinality, sub_part, packed, nullable, idx_type, comment, idx_comment)
        @name = name
        @unique = unique == 1 ? true : false
        @sequence_in_idx = sequence_in_idx
        @colname = colname
        @collation = collation
        @cardinality = cardinality
        @sub_part = sub_part
        @packed  = packed.nil? ? false : packed
        @nullable = nullable == 'YES' ? true : false
        @idx_type = idx_type
        @comment = comment
        @idx_comment = idx_comment
      end
    end
  end
end
