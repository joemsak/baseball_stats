Then(/^calling calculate should return the player$/) do
  player_id = @calculator.calculate(2009, 2010)
  player_id.should == "aards01"
end

When(/^I create an improved batting average calculator$/) do
  @calculator = StatsReporter::StatsCalculator::ImprovedBattingAverage.new(@stats_csv)
end

Then(/^calling calculate should raise NoStatsToCalculateError$/) do
  expect {
    @calculator.calculate(2009, 2010)
  }.to raise_error(StatsReporter::StatsCalculator::NoStatsToCalculateError)
end
