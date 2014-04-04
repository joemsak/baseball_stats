require 'baseball_stats/calculators/improved_batting_average'
require 'baseball_stats/calculators/slugging_percentage'
require 'baseball_stats/calculators/triple_crown_winner'

module BaseballStats
  module Calculators
    AMERICAN_LEAGUE = 'AL'
    AT_BATS         = 'AB'
    DOUBLES         = '2B'
    HITS            = 'H'
    HOMERUNS        = 'HR'
    LEAGUE          = 'league'
    NATIONAL_LEAGUE = 'NL'
    PLAYER_ID       = 'playerID'
    RBI             = 'RBI'
    TRIPLES         = '3B'
    YEAR_ID         = 'yearID'

    attr_accessor :csv, :year

    def initialize(raw_data, year)
      @csv  = CSV.parse(raw_data, headers: true, converters: :all)
      @year = year
      raise NoStatsToCalculateError if csv.blank?
    end

    def calculate
      raise "#{self.class.name} must implement #calculate"
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
