When(/^I display the "(.*?)" report with args:$/) do |klass, table|
  args = table.raw.flatten
  args[0] = args[0].to_i # the year
  reporter_class = "BaseballStats::Reporters::#{klass}".constantize
  @reporter = reporter_class.new(*args)
end

Then(/^I should see that no stats are available to calculate$/) do
  @reporter.body.should include "There are no stats to calculate."
end

Then(/^I should see the most improved batting average$/) do
  @reporter.body.should include "Most improved batting average from"
  @reporter.body.should include "2009 to 2010: Player Two"
end

Then(/^I should see that not enough stats were found$/) do
  @reporter.body.should include "2010: Not enough stats were found."
end

Then(/^I should see that no eligible stats were found$/) do
  @reporter.body.should include "Percentage: No eligible stats were found."
end

Then(/^I should see the slg for the team and year specified$/) do
  @reporter.body.should include "2007 OAK Slugging Percentage: "
  @reporter.body.should include "\nPlayer Three - 0.356\nPlayer Four - 0.459"
end

Then(/^I should see there was no winner$/) do
  @reporter.body.should include "League: (No winner)"
end

Then(/^I should see the triple crown winners$/) do
  header = "Triple Crown Eligible or Winner for"
  @reporter.body.should include "#{header} 2012:"
  @reporter.body.should include "\nAmerican League: AL Player Two"
  @reporter.body.should include "\nNational League: NL Player Two"
end
