class CalculationReport
  attr_accessor :message

  def initialize
    @message = "There are no stats to calculate."
  end

  def display_report
  end
end

Given(/^that no stats exist$/) do
end

When(/^I display the stats report$/) do
  @report = CalculationReport.new
  @report.display_report
end

Then(/^I should see that no stats are available to calculate$/) do
  @report.message.should eq "There are no stats to calculate."
end
