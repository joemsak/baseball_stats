module BaseballStats
  module Calculators
    class ImprovedBattingAverage
      include Calculators

      def calculate
        players = {}

        eligible_players.each do |player_id, stats|
          # this part is why we're sorting in #eligible_players
          this_year = self.class.formula(stats[1])
          prev_year = self.class.formula(stats[0])
          players[player_id] = this_year - prev_year
        end

        players.max_by { |_, v| v }.first
      end

      def self.formula(stats)
        stats[HITS] / stats[AT_BATS].to_f
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
    end
  end
end
