When(/^I display the stats report$/) do
  @report = BaseballStats::Report.new(@stats_csv)
  @report.display_report
end

Then(/^I should see that no stats are available to calculate$/) do
  @report.message.should eq "There are no stats to calculate."
end

Then(/^I should see the calculated stats$/) do
  @report.message.should include "Most improved batting average from 2009 to 2010:"
end
