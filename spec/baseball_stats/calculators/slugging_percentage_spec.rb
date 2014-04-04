require 'spec_helper'
require 'baseball_stats/calculators'

module BaseballStats
  module Calculators
    describe SluggingPercentage do
      include CalculatorTestHelper
      subject { SluggingPercentage }

      describe "#calculate" do
        context "when no stats exist" do
          it "raises a NoStatsToCalculateError" do
            expect {
              build_calculator(stats, 2010, 'ANY')
            }.to raise_error(NoStatsToCalculateError)
          end
        end

        context "when some stats exist" do
          before do
            stats << "\nallenbr01,2011,AL,OAK,41,146,18,30,9,2,3,11,2,0"
            stats << "\nallenbr02,2011,AL,OAK,41,146,18,43,7,1,5,11,2,0"
          end

          context "but no players are found for the requested team" do
            it "raises a NoEligibleStatsFoundError" do
              assert_calculator_raised(NoEligibleStatsFoundError, stats,
                                       2010, 'BLA')
            end
          end

          context "but no players were found for the requested year" do
            it "raises a NoEligibleStatsFoundError" do
              assert_calculator_raised(NoEligibleStatsFoundError, stats,
                                       2009, 'OAK')
            end
          end

          context "and there are stats available for a meaningful answer" do
            it "returns the slugging percentage for all players found" do
              # (( H - 2B - 3B - HR) + (2 * 2B) + (3 * 3B) + (4 * HR)) / AB
              # ((73 - 16 - 3 - 8) + (2 * 16) + (3 * 3) + (4 * 8)) / 292
              # (46 + 32 + 9 + 32) / 292
              # 119 / 292 = 0.408
              build_calculator(stats, 2011, 'OAK')
              calculator.calculate.should == 0.408
            end
          end
        end
      end
    end
  end
end
