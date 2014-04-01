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
