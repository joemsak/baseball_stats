require 'csv'
require 'active_support/all'
require 'baseball_stats/reporters'

module BaseballStats
  class Report
    attr_accessor :message, :csv

    def initialize(raw_data)
      @message = ''
      @csv     = CSV.parse(raw_data || '', headers: true, converters: :all)
    end

    def display_report
      add_improved_batting_average_to_message
    end

    private
    def add_improved_batting_average_to_message
      begin
        calculator = Calculators::ImprovedBattingAverage.new(csv, 2010)
        @message << Reports::ImprovedBattingAverage::HEADER
        @message << "2009 to 2010: " << calculator.calculate
      rescue => e
        @message = e.message
      end
    end
  end
end
