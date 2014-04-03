require 'csv'
require 'active_support/all'

module CalculatorTestHelper
  def self.included(base)
    base.let(:stats) {
      "playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS"
    }
  end

  def calculator
    @calculator
  end

  def build_calculator(*args)
    @calculator = subject.new(*args)
  end

  def assert_calculator_raised(error, *args)
    build_calculator(*args)
    expect {
      calculator.calculate
    }.to raise_error(error)
  end
end
