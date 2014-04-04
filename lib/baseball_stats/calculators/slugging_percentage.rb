module BaseballStats
  module Calculators
    class SluggingPercentage
      include Calculators
      attr_accessor :team_id

      def initialize(year, team_id)
        super(year)
        @team_id = team_id
      end

      def calculate
        results = {}
        eligible_players.each do |p|
          slg = ((p[HITS] - p[DOUBLES] - p[TRIPLES] - p[HOMERUNS]) +
                 (2 * p[DOUBLES]) +
                 (3 * p[TRIPLES]) +
                 (4 * p[HOMERUNS])) / p[AT_BATS].to_f

          key = p[PLAYER_ID]
          results[key] = slg.round(3)
        end
        results
      end

      private
      def eligible_players
        players = select_from_csv do |player|
          player[TEAM_ID] == team_id &&
            player[YEAR_ID] == year &&
              player[AT_BATS] > 0
        end
        players.blank? ? raise(NoEligibleStatsFoundError) : players
      end
    end
  end
end
