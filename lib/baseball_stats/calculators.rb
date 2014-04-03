require 'baseball_stats/calculators/improved_batting_average'

module BaseballStats
  module Calculators
    class NoStatsToCalculateError < StandardError
      def message
        "There are no stats to calculate."
      end
    end

    class NotEnoughStatsFoundError < StandardError; end
  end
end
