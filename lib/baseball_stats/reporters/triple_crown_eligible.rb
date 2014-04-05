module BaseballStats
  module Reporters
    class TripleCrownEligible
      include Reporters

      def header
        "Triple Crown Eligible or Winner for #{year}:"
      end

      def result
        calc = BaseballStats::Calculators::TripleCrownEligible.new(year)
        winners = calc.calculate
        winners.map { |league, player_id|
          name = player_id
          name = '(No winner)' if player_id == 0
          "\n#{league}: #{name}"
        }.join
      end
    end
  end
end
