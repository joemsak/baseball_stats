module BaseballStats
  module Reporters
    class TripleCrownEligible
      include Reporters

      def self.menu_name
        "National and American League Triple Crown Eligible by year."
      end

      def header
        "Triple Crown Eligible or Winner for #{year}:"
      end

      def result
        calc = BaseballStats::Calculators::TripleCrownEligible.new(year)
        winners = calc.calculate
        winners.map { |league, player_id|
          name = player_name(player_id)
          "\n#{league}: #{name}"
        }.join
      end
    end
  end
end
