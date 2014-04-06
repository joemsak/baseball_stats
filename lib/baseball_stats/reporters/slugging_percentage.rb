module BaseballStats
  module Reporters
    class SluggingPercentage
      include Reporters

      attr_accessor :team_id

      def initialize(year, team_id)
        super(year)
        @team_id = team_id
      end

      class << self
        def menu_name
          "Slugging percentage by team and year."
        end

        def prompt(printer, input_device)
          super do |args|
            printer.write("Please enter the team ID you want stats for:")
            args << input_device.prompt
          end
        end
      end

      def header
        "#{year} #{team_id} Slugging Percentage: "
      end

      def result
        calc = Calculators::SluggingPercentage.new(year, team_id)
        results = calc.calculate.map do |id, slg|
          "\n#{player_name(id)} - #{slg}"
        end
        results.join
      end
    end
  end
end
