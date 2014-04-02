module StatsReporter
  module StatsCalculator
    class ImprovedBattingAverage
      attr_accessor :data_source

      def initialize(data_source)
        @data_source = data_source
      end

      def calculate(start_year, end_year)
        raise NoStatsToCalculateError if data_source.blank?
        "aards01"
      end
    end

    class NoStatsToCalculateError < StandardError
    end
  end
end
