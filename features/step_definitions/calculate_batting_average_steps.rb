module StatsCalculator
  class ImprovedBattingAverage
    attr_accessor :data_source

    def initialize(data_source)
      @data_source = data_source
    end

    def calculate(start_year, end_year)
      raise NoStatsToCalculateError if data_source.blank?
    end
  end

  class NoStatsToCalculateError < StandardError
  end
end

When(/^I create an improved batting average calculator$/) do
  @calculator = StatsCalculator::ImprovedBattingAverage.new(@stats_csv)
end

Then(/^calling calculate should raise NoStatsToCalculateError$/) do
  expect {
    @calculator.calculate(2009, 2010)
  }.to raise_error(StatsCalculator::NoStatsToCalculateError)
end
