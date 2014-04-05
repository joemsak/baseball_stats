module BaseballStats
  module Reporters
    class SluggingPercentage
      include Reporters

      attr_accessor :team_id

      def initialize(year, team_id)
        super(year)
        @team_id = team_id
      end

      def self.menu_name
        "Slugging percentage by team and year."
      end

      def self.prompt(printer, input_device)
        printer.write("Please enter the ID of the team you want to see.")
        team_id = input_device.prompt

        printer.write("Please enter the year you want to see stats for.")
        year = input_device.prompt.to_i

        report(printer, year, team_id)
      end

      def header
        "#{year} #{team_id} Slugging Percentage: "
      end

      def result
        calc = Calculators::SluggingPercentage.new(year, team_id)
        calc.calculate.map { |id, slg| "\n#{id} - #{slg}" }.join
      end
    end
  end
end
