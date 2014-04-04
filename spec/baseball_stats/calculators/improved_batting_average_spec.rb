require 'spec_helper'
require 'baseball_stats/calculators'

module BaseballStats
  module Calculators
    describe ImprovedBattingAverage do
      include CalculatorTestHelper
      subject { ImprovedBattingAverage }

      describe "#calculate" do
        context "when no stats exist" do
          it "raises a NoStatsToCalculateError" do
            assert_calculator_raised(NoStatsToCalculateError, 2001)
          end
        end

        context "when some stats exist" do
          before do
            stats << "\naardsda01,2010,AL,SEA,73,200,0,180,0,0,0,0,0,0"
            stats << "\naardsda01,2009,AL,SEA,73,200,0,180,0,0,0,0,0,0"
          end

          context "but no one has 200 at-bats" do
            before { stats.gsub!(/,200,/, ',199,') }

            it "raises a NotEnoughStatsFoundError" do
              assert_calculator_raised(NotEnoughStatsFoundError, 2009)
            end
          end

          context "but no one is in the date range" do
            it "raises a NotEnoughStatsFoundError" do
              assert_calculator_raised(NotEnoughStatsFoundError, 2011)
            end
          end

          context "and there are enough to calculate a meaningful answer" do
            before do
              stats << "\naardsda02,2010,AL,SEA,73,200,0,190,0,0,0,0,0,0"
              stats << "\naardsda02,2009,AL,SEA,73,200,0,180,0,0,0,0,0,0"
            end

            it "returns the playerID of the most improved player" do
              build_calculator(2010)
              calculator.calculate.should == 'aardsda02'
            end
          end
        end
      end
    end
  end
end
