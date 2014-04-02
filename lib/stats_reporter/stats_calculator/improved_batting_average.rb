module StatsReporter
  module StatsCalculator
    class ImprovedBattingAverage
      attr_accessor :csv

      def initialize(csv)
        @csv = csv
      end

      def calculate(start_year, end_year)
        raise NoStatsToCalculateError if csv.blank?

        best = eligible_players.max_by do |player|
          player['H'] / player['AB'].to_f
        end

        best.blank? ? "No players had enough At-Bats" : best['playerID']
      end

      private
      def eligible_players
        csv.to_enum.reject { |p| p['AB'] < 200 }
      end
    end

    class NoStatsToCalculateError < StandardError
    end
  end
end
