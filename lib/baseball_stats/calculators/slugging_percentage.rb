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
        slugging_percentage = ((hits - doubles - triples - homeruns) +
          (2 * doubles) + (3 * triples) + (4 * homeruns)) / at_bats.to_f
        slugging_percentage.round(3)
      end

      private
      def eligible_players
        super do |player|
          player['teamID'] == team_id &&
            player['yearID'] == year
        end
      end

      def hits
        collect_and_add('H')
      end

      def doubles
        collect_and_add('2B')
      end

      def triples
        collect_and_add('3B')
      end

      def homeruns
        collect_and_add('HR')
      end

      def at_bats
        collect_and_add('AB')
      end

      def collect_and_add(key)
        eligible_players.collect { |p| p[key]  }.reduce(:+)
      end
    end
  end
end
