module BaseballStats
  module Calculators
    class ImprovedBattingAverage
      include Calculators

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
        players = super do |player|
          player['yearID'].between?(year - 1, year) &&
          player['AB'] > 199
        end
        raise NotEnoughStatsFoundError if players.size < 2

        players.group_by { |p| p['playerID'] }.reject { |_, stats|
          stats.size < 2 # no sense comparing players w/o stats in both years
        }
      end

      def batting_average(stats)
        stats['H'] / stats['AB'].to_f
      end
    end
  end
end
