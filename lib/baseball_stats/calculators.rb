require 'baseball_stats/calculators/improved_batting_average'
require 'baseball_stats/calculators/slugging_percentage'

module BaseballStats
  module Calculators
    attr_accessor :csv, :year

    def initialize(raw_data, year)
      @csv  = CSV.parse(raw_data, headers: true, converters: :all)
      @year = year
      raise NoStatsToCalculateError if csv.blank?
    end

    class NoStatsToCalculateError < StandardError
      def message
        "There are no stats to calculate."
      end
    end

    class NotEnoughStatsFoundError < StandardError; end
    class NoEligibleStatsFoundError < StandardError; end

    private
    def eligible_players
      @eligible_players ||= csv.to_enum.select do |player|
        yield(player)
      end
    end
  end
end
