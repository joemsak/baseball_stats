Given(/^that no stats exist$/) do
end

Given(/^(?:that )?some (?:stats|at-bats) exist$/) do
  @stats_csv = "playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS\naardsda01,2009,AL,SEA,73,0,0,2,0,0,0,0,0,0"
end

Given(/^(?:that )?enough at\-bats exist for multiple players$/) do
  step "some at-bats exist"
  @stats_csv << "\naardsda02,2009,AL,SEA,73,0,0,1,0,0,0,0,0,0"
  step "set at-bats to 200"
end

Given(/^that enough at\-bats exist for multiple players out of date range$/) do
  step "enough at-bats exist for multiple players"
  @stats_csv << "\naardsda03,2007,AL,SEA,73,200,0,3,0,0,0,0,0,0"
end

Given(/^that enough at\-bats exist for multiple players in date range$/) do
  step "enough at-bats exist for multiple players"
  @stats_csv << "\naardsda02,2010,AL,SEA,73,200,0,2,0,0,0,0,0,0"
  @stats_csv << "\naardsda01,2010,AL,SEA,73,200,0,2,0,0,0,0,0,0"
end

Then(/^calling calculate should return the most improved player$/) do
  player_id = step "calculate best batting average"
  player_id.should == "aardsda02"
end

Given(/^that not enough at-bats exist for a batting average$/) do
  step "some at-bats exist"
  step "set at-bats to 199"
end

When(/^I create an improved batting average calculator$/) do
  csv = @stats_csv.blank? ? '' : CSV.parse(@stats_csv,
                                           headers: true,
                                           converters: :all)
  @calculator = StatsReporter::StatsCalculator::ImprovedBattingAverage.new(csv,
                                                                          2010)
end

Then(/^I should see there aren't enough at-bats to calculate$/) do
  expect {
    step "calculate best batting average"
  }.to raise_error(StatsReporter::StatsCalculator::StatsMustHaveAtLeast200AtBatsError)
end

Then(/^calling calculate should return the player$/) do
  player_id = step("calculate best batting average")
  player_id.should == "aardsda01"
end

Then(/^calling calculate should return the better player$/) do
  player_id = step("calculate best batting average")
  # the better player has 2 hits / 200 at-bats
  # other player has 1 / 200
  player_id.should == "aardsda01"
end

Then(/^calling calculate should return the better player in the date range$/) do
  step "calling calculate should return the better player"
  # this just so happens to be the same player in this step
end

Then(/^calling calculate should raise NoStatsToCalculateError$/) do
  expect {
    step "calculate best batting average"
  }.to raise_error(StatsReporter::StatsCalculator::NoStatsToCalculateError)
end

#private steps
When(/^calculate best batting average$/) do
  @calculator.calculate
end

When(/^set at-bats to (\d+)$/) do |num|
  @stats_csv.gsub!(/73,0,/, "73,#{num},")
end
