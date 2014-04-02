Given(/^that no stats exist$/) do
  @stats_csv = ''
end

Given(/^(?:that )?some stats exist$/) do
  @stats_csv = "playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS\n"
  @stats_csv << "aardsda01,2009,AL,SEA,73,200,0,180,0,0,0,0,0,0"
  @stats_csv << "aardsda01,2010,AL,SEA,73,200,0,180,0,0,0,0,0,0"
end

Given(/^(?:that )?enough at\-bats exist for multiple players(?: in date range)?$/) do
  step "some stats exist"
  @stats_csv << "\naardsda02,2009,AL,SEA,73,200,0,180,0,0,0,0,0,0"
  @stats_csv << "\naardsda02,2010,AL,SEA,73,200,0,190,0,0,0,0,0,0"
end

Given(/^that enough at\-bats exist for multiple players out of date range$/) do
  step "enough at-bats exist for multiple players"
  @stats_csv << "\naardsda03,2007,AL,SEA,73,200,0,198,0,0,0,0,0,0"
  @stats_csv << "\naardsda03,2008,AL,SEA,73,200,0,199,0,0,0,0,0,0"
end

Given(/^that not enough at-bats exist for a batting average$/) do
  step "some stats exist"
  step "set at-bats to 199"
end

When(/^(?:I )?create an improved batting average calculator$/) do
  @calc = BaseballStats::Calculators::ImprovedBattingAverage.new(@stats_csv,
                                                                 2010)
end

Then(/^calling calculate should return the most improved player$/) do
  player_id = @calc.calculate
  player_id.should == "aardsda02"
end

Then(/^I should see there aren't enough at-bats to calculate$/) do
  expect {
    @calc.calculate
  }.to raise_error(BaseballStats::Calculators::NoPlayersFoundWithMinimumStats)
end

Then(/^calling calculate should return the player$/) do
  player_id = @calc.calculate
  player_id.should == "aardsda01"
end

Then(/^calling calculate should return the better player(?: in the date range)?$/) do
  player_id = @calc.calculate
  player_id.should == "aardsda02"
end

Then(/^calling calculate should raise NoStatsToCalculateError$/) do
  expect {
    @calc.calculate
  }.to raise_error(BaseballStats::Calculators::NoStatsToCalculateError)
end

Then(/^initializing the calculator should raise NoStatsToCalculateError$/) do
  expect {
    step "create an improved batting average calculator"
  }.to raise_error(BaseballStats::Calculators::NoStatsToCalculateError)
end

#private steps
When(/^set at-bats to (\d+)$/) do |num|
  @stats_csv.gsub!(/,200,/, ",#{num},")
end
