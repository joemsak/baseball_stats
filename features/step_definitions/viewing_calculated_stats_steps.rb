Given(/^that no stats exist$/) do
end

Given(/^(?:that )?(some|enough) (?:stats|at-bats) exist(?: for (one|multiple) players?)?$/) do |how_many_stats, how_many_players|
  @stats_csv = "playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS\naardsda01,2009,AL,SEA,73,0,0,2,0,0,0,0,0,0"

  if how_many_players == "multiple"
    @stats_csv << "\naardsda02,2009,AL,SEA,73,0,0,1,0,0,0,0,0,0"
  end

  if how_many_stats == "enough"
    step("set at-bats to 200")
  end
end

When(/^I display the stats report$/) do
  @report = StatsReporter::CalculationReport.new(@stats_csv)
  @report.display_report
end

Then(/^I should see that no stats are available to calculate$/) do
  @report.message.should eq "There are no stats to calculate."
end

Then(/^I should see the calculated stats$/) do
  @report.message.should include "Most improved batting average from 2009 to 2010:"
end
