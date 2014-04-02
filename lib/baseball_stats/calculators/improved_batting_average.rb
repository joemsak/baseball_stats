module BaseballStats
  module Calculators
    class ImprovedBattingAverage
      attr_accessor :csv, :year

      def initialize(raw_data, year)
        raise NoStatsToCalculateError if raw_data.blank?
        @csv  = CSV.parse(raw_data, headers: true, converters: :all)
        @year = year
      end

      def calculate
        players = {}

        eligible_players.each do |player_id, stats|
          this_year = batting_average(stats[1])
          prev_year = batting_average(stats[0])
          players[player_id] = this_year - prev_year
        end

        players.max_by { |_, v| v }.first
      end

      private
      def eligible_players
        players = get_players_in_date_range
        raise NoStatsFoundInDateRangeError if players.blank?

        players = get_players_with_minimum_stats(players)
        raise NoPlayersFoundWithMinimumStats if players.blank?

        players.group_by { |p| p['playerID'] }.reject { |_, stats| stats.size < 2 }
        # no sense in comparing players who don't have stats in both years
      end

      def batting_average(stats)
        stats['H'] / stats['AB'].to_f
      end

      def get_players_in_date_range
        csv.to_enum.reject do |player|
          not player['yearID'].between?(year - 1, year)
        end
      end

      def get_players_with_minimum_stats(players)
        players.reject { |p| p['AB'] < 200 }
      end
    end
  end
end
