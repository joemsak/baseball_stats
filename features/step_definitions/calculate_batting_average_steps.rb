Given(/^that not enough at-bats exist for a batting average$/) do
  step "some at-bats exist"
  step "set at-bats to 199"
end

When(/^I create an improved batting average calculator$/) do
  csv = @stats_csv.blank? ? '' : CSV.parse(@stats_csv,
                                           headers: true,
                                           converters: :all)
  @calculator = StatsReporter::StatsCalculator::ImprovedBattingAverage.new(csv)
end

Then(/^I should see there aren't enough at-bats to calculate$/) do
  result = step "calculate 2009 to 2010"
  result.should == "No players had enough At-Bats"
end

Then(/^calling calculate should return the player$/) do
  player_id = step("calculate 2009 to 2010")
  player_id.should == "aardsda01"
end

Then(/^calling calculate should return the better player$/) do
  player_id = step("calculate 2009 to 2010")
  # the better player has 2 hits / 200 at-bats
  # other player has 1 / 200
  player_id.should == "aardsda01"
end

Then(/^calling calculate should raise NoStatsToCalculateError$/) do
  expect {
    step "calculate 2009 to 2010"
  }.to raise_error(StatsReporter::StatsCalculator::NoStatsToCalculateError)
end

#private steps
When(/^calculate 2009 to 2010$/) do
  @calculator.calculate(2009, 2010)
end

When(/^set at-bats to (\d+)$/) do |num|
  @stats_csv.gsub!(/73,0,/, "73,#{num},")
end
