module BaseballStats
  module Calculators
    class SluggingPercentage
      include Calculators
      attr_accessor :team_id

      def initialize(raw_data, year, team_id)
        super(raw_data, year)
        @team_id = team_id
      end

      def calculate
        raise NoEligibleStatsFoundError if eligible_players.blank?
        results = {}
        eligible_players.each do |p|
          slugging_percentage = (
            (p[HITS] - p[DOUBLES] - p[TRIPLES] - p[HOMERUNS]) +
            (2 * p[DOUBLES]) + (3 * p[TRIPLES]) + (4 * p[HOMERUNS])
          ) / p[AT_BATS].to_f

          results[p[PLAYER_ID]] = slugging_percentage.round(3)
        end
        results
      end

      private
      def eligible_players
        select_from_csv do |player|
          player['teamID'] == team_id && player['yearID'] == year
        end
      end
    end
  end
end
