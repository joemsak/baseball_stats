module StatsReporter
  module StatsCalculator
    class ImprovedBattingAverage
      attr_accessor :csv, :start_y, :end_y

      def initialize(csv, start_y, end_y)
        @csv     = csv
        @start_y = start_y
        @end_y   = end_y
      end

      def calculate
        raise NoStatsToCalculateError if csv.blank?

        best = eligible_players.max_by do |player|
          player['H'] / player['AB'].to_f
        end

        best.blank? ? "No players had enough At-Bats" : best['playerID']
      end

      private
      def eligible_players
        csv.to_enum.reject do |player|
          player['AB'] < 200 || !player['yearID'].between?(start_y, end_y)
        end
      end
    end

    class NoStatsToCalculateError < StandardError
    end
  end
end
