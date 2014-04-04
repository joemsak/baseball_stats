require 'baseball_stats/calculators/improved_batting_average'
require 'baseball_stats/calculators/slugging_percentage'

module BaseballStats
  module Calculators
    AT_BATS   = 'AB'
    DOUBLES   = '2B'
    HITS      = 'H'
    HOMERUNS  = 'HR'
    PLAYER_ID = 'playerID'
    TRIPLES   = '3B'
    YEAR_ID   = 'yearID'

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
    def select_from_csv
      @selected_from_csv ||= csv.to_enum.select do |player|
        yield(player)
      end
    end
  end
end
