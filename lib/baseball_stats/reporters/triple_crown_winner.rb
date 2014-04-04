module BaseballStats
  module Reporters
    class TripleCrownWinner
      include Reporters

      def header
        "Triple Crown Winners for #{year}:"
      end

      def result
        calc = BaseballStats::Calculators::TripleCrownWinner.new(year)
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
