When(/^I display the stats report$/) do
  @report = BaseballStats::Report.new(@stats_csv)
  @report.display_report
end

Then(/^I should see that no stats are available to calculate$/) do
  @report.message.should include "2010: There are no stats to calculate."
end

Then(/^I should see the most improved batting average$/) do
  @report.message.should include "Most improved batting average from"
  @report.message.should include "2009 to 2010: aardsda02"
end

Then(/^I should see that not enough stats were found$/) do
  @report.message.should include "2010: Not enough stats were found."
end

Then(/^I should see that no eligible stats were found$/) do
  @report.message.should include "Percentage: No eligible stats were found."
end

Then(/^I should see the slg for the team and year specified$/) do
  @report.message.should include "2007 OAK Slugging Percentage: "
  @report.message.should include "\nallenbr01 - 0.356\nallenbr02 - 0.459"
end

Then(/^I should see there was no winner$/) do
  @report.message.should include "League: (No winner)"
end

Then(/^I should see the triple crown winners$/) do
  @report.message.should include "Triple Crown Winners for 2011:"
  @report.message.should include "\nAmerican League: alplaye02"
  @report.message.should include "\nNational League: nlplaye02"
  @report.message.should include "\nTriple Crown Winners for 2012:"
  @report.message.should include "\nAmerican League: alplaye02"
  @report.message.should include "\nNational League: nlplaye02"
end
