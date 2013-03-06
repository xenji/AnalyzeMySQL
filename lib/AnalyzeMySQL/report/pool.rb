module AnalyzeMySQL
  module Report
    class Pool
      attr_reader :report
      def initialize
        @report = []
      end
      def <<(val)
        @report.concat val
      end
    end
  end
end
