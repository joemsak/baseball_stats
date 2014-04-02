Given(/^that no stats exist$/) do
  @stats_csv = ''
end

Given(/^(?:that )?some (?:stats|at-bats) exist$/) do
  @stats_csv = "playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS\n"
  @stats_csv << "aardsda01,2009,AL,SEA,73,0,0,2,0,0,0,0,0,0"
  # 01 has 2 hits
end

Given(/^(?:that )?enough at\-bats exist for multiple players$/) do
  step "some at-bats exist"
  @stats_csv << "\naardsda02,2009,AL,SEA,73,0,0,1,0,0,0,0,0,0"
  # 02 has 1 hit
  step "set at-bats to 200"
  # everyone has 200 At-Bats
end

Given(/^that enough at\-bats exist for multiple players out of date range$/) do
  step "enough at-bats exist for multiple players"
  @stats_csv << "\naardsda03,2007,AL,SEA,73,200,0,3,0,0,0,0,0,0"
  # 03 has 3 hits, but is out of date range
end

Given(/^that enough at\-bats exist for multiple players in date range$/) do
  step "enough at-bats exist for multiple players"
  @stats_csv << "\naardsda02,2010,AL,SEA,73,200,0,2,0,0,0,0,0,0"
  @stats_csv << "\naardsda01,2010,AL,SEA,73,200,0,2,0,0,0,0,0,0"
  # 02 improved by 1 hit
  # 01 did not improve, stayed the same
end

Then(/^calling calculate should return the most improved player$/) do
  player_id = @calc.calculate
  player_id.should == "aardsda02"
end

Given(/^that not enough at-bats exist for a batting average$/) do
  step "some at-bats exist"
  step "set at-bats to 199"
end

When(/^I create an improved batting average calculator$/) do
  @calc = BaseballStats::Calculators::ImprovedBattingAverage.new(@stats_csv,
                                                                 2010)
end

Then(/^I should see there aren't enough at-bats to calculate$/) do
  expect {
    @calc.calculate
  }.to raise_error(BaseballStats::Calculators::StatsMustHaveAtLeast200AtBatsError)
end

Then(/^calling calculate should return the player$/) do
  player_id = @calc.calculate
  player_id.should == "aardsda01"
end

Then(/^calling calculate should return the better player$/) do
  player_id = @calc.calculate
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
    @calc.calculate
  }.to raise_error(BaseballStats::Calculators::NoStatsToCalculateError)
end

#private steps
When(/^set at-bats to (\d+)$/) do |num|
  @stats_csv.gsub!(/73,0,/, "73,#{num},")
end
