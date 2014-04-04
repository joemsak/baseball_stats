require 'baseball_stats/reporters/improved_batting_average'
require 'baseball_stats/reporters/slugging_percentage'
require 'baseball_stats/reporters/triple_crown_winner'

module BaseballStats
  module Reporters
    attr_accessor :year

    def initialize(year, *args)
      @year = year
    end

    def header
      raise "Abstract method #header called for #{self.class.name}"
    end

    def result
      raise "Abstract method #result called for #{self.class.name}"
    end

    private
    def raw_data
      BaseballStats::Report.raw_data
    end
  end
end
