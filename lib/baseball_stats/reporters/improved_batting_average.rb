module BaseballStats
  module Reporters
    class ImprovedBattingAverage
      attr_accessor :year

      def initialize(raw_data, year)
        @raw_data = raw_data
        @year     = year
      end

      def header
        "Most improved batting average from #{year - 1} to #{year}: "
      end

      def result
        calc = Calculators::ImprovedBattingAverage.new(raw_data, year)
        calc.calculate
      end

      private
      def raw_data
        @raw_data ||= ''
      end
    end
  end
end
