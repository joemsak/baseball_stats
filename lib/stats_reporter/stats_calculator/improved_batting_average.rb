module StatsReporter
  module StatsCalculator
    class ImprovedBattingAverage
      attr_accessor :csv, :year

      def initialize(csv, year)
        @csv  = csv
        @year = year
      end

      def calculate
        players = {}

        eligible_players.each do |player_id, stats|
          this_year = batting_average(stats[1] || stats[0])
          prev_year = batting_average(stats[0])
          players[player_id] = this_year - prev_year
        end

        players.max_by { |_, v| v }.first
      end

      private
      def eligible_players
        raise NoStatsToCalculateError if csv.blank?

        players = csv.to_enum.reject do |player|
          not player['yearID'].between?(year - 1, year)
        end
        raise NoStatsFoundInDateRangeError if players.blank?

        players.reject! { |p| p['AB'] < 200 }
        raise StatsMustHaveAtLeast200AtBatsError if players.blank?

        players.group_by { |p| p['playerID'] }
      end

      def batting_average(stats)
        stats['H'] / stats['AB'].to_f
      end
    end

    class NoStatsToCalculateError < StandardError; end
    class NoStatsFoundInDateRangeError < StandardError; end
    class StatsMustHaveAtLeast200AtBatsError < StandardError; end
  end
end
