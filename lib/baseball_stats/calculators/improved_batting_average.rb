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
        players = select_from_csv do |player|
          player[YEAR_ID].between?(year - 1, year) && player[AT_BATS] > 199
        end
        raise NotEnoughStatsFoundError if players.size < 2

        players.sort_by { |player|
          player[YEAR_ID]
        }.group_by      { |player|
          player[PLAYER_ID]
        }.reject        { |_, stats| # no sense comparing players
          stats.size < 2             # w/o stats in both years
        }
      end

      def batting_average(stats)
        stats[HITS] / stats[AT_BATS].to_f
      end
    end
  end
end
