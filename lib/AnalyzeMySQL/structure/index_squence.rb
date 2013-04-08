module AnalyzeMySQL
  module Structure
    class IndexSquence
      attr_reader :name, :indexes

      def initialize(key_name, indexes = [])
        @name = key_name
        @indexes = indexes
      end

      def [](idx)
        if idx.is_a? Numeric
          @indexes[idx]
        else
          if idx.is_a? String
            @indexes.collect { |idx_field| idx == idx_field.name }.first
          end
        end
      end

      def <<(new_idx)
        @indexes << new_idx unless @indexes.include? new_idx
      end

    end
  end
end