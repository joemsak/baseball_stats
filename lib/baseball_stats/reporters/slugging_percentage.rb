module BaseballStats
  module Reporters
    class SluggingPercentage
      include Reporters

      attr_accessor :team_id

      def initialize(year, team_id)
        super
        @team_id = team_id
      end

      def header
        "#{year} #{team_id} Slugging Percentage: "
      end

      def result
        calc = Calculators::SluggingPercentage.new(year, team_id)
        calc.calculate.map { |player, slg|
          "\n#{player} - #{slg}"
        }.join
      end
    end
  end
end
