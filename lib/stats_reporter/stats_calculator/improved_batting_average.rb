module StatsReporter
  module StatsCalculator
    class ImprovedBattingAverage
      attr_accessor :csv

      def initialize(csv)
        @csv = csv
      end

      def calculate(start_year, end_year)
        raise NoStatsToCalculateError if csv.blank?
        name = "No players had enough At-Bats"
        csv.each do |player|
          if player['AB'] > 199
            name = player['playerID']
          end
        end
        name
      end
    end

    class NoStatsToCalculateError < StandardError
    end
  end
end
