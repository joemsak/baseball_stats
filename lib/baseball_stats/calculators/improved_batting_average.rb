module BaseballStats
  module Calculators
    class ImprovedBattingAverage
      attr_accessor :csv, :year

      def initialize(raw_data, year)
        @csv  = CSV.parse(raw_data, headers: true, converters: :all)
        @year = year
        raise NoStatsToCalculateError if csv.blank?
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
        players = get_players_with_minimum_stats(players)

        raise NotEnoughStatsFoundError if players.size < 2

        players.group_by { |p| p['playerID'] }.reject { |_, stats|
          stats.size < 2 # no sense comparing players w/o stats in both years
        }
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
