require 'active_support/all'

class CalculationReport
  attr_accessor :message, :data_source

  def initialize(data_source)
    @data_source = data_source
  end

  def display_report
    display_no_stats and return if data_source.blank?
    @message = "Most improved batting average from 2009 to 2010:"
  end

  private
  def display_no_stats
    @message = "There are no stats to calculate."
  end
end

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
