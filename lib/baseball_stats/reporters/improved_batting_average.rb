module BaseballStats
  module Reporters
    class ImprovedBattingAverage
      include Reporters

      def self.menu_name
        "Most improved batting average by year."
      end

      def header
        "Most improved batting average from #{year - 1} to #{year}: "
      end

      def result
        calc = Calculators::ImprovedBattingAverage.new(year)
        player_name(calc.calculate)
      end
    end
  end
end
