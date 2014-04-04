require 'csv'
require 'active_support/all'
require 'baseball_stats/report'

module CalculatorTestHelper
  def self.included(base)
    header_row = "playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS"
    base.before { BaseballStats::Report.raw_data = header_row }
    base.let(:stats) { BaseballStats::Report.raw_data }
  end

  def calculator
    @calculator
  end

  def build_calculator(*args)
    @calculator = subject.new(*args)
  end

  def assert_calculator_raised(error, *args)
    expect {
      build_calculator(*args)
      calculator.calculate
    }.to raise_error(error)
  end
end
