Given(/^that no stats exist$/) do
end

Given(/^that some stats exist$/) do
  @stats_csv = "aardsda01,2009,AL,SEA,73,0,0,0,0,0,0,0,0,0"
end

When(/^I display the stats report$/) do
  @report = CalculationReport.new(@stats_csv)
  @report.display_report
end

Then(/^I should see that no stats are available to calculate$/) do
  @report.message.should eq "There are no stats to calculate."
end

Then(/^I should see the calculated stats$/) do
  @report.message.should include "Most improved batting average from 2009 to 2010:"
end
