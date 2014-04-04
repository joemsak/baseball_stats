module BaseballStats
  module Reporters
    class ImprovedBattingAverage
      include Reporters

      def header
        "Most improved batting average from #{year - 1} to #{year}: "
      end

      def result
        calc = Calculators::ImprovedBattingAverage.new(year)
        calc.calculate
      end
    end
  end
end
