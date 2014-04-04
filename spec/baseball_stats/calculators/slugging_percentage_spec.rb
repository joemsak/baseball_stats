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
            assert_calculator_raised(NoStatsToCalculateError, 2010, 'ANY')
          end
        end

        context "when some stats exist" do
          before do
            stats << "\nallenbr01,2011,AL,OAK,41,146,18,30,9,2,3,11,2,0"
            stats << "\nallenbr02,2011,AL,OAK,41,146,18,43,7,1,5,11,2,0"
            stats << "\nallenbr02,2012,AL,OAK,41,146,18,43,7,1,5,11,2,0"
          end

          context "but no players are found for the requested team" do
            it "raises a NoEligibleStatsFoundError" do
              assert_calculator_raised(NoEligibleStatsFoundError, 2011, 'BLA')
            end
          end

          context "but no players were found for the requested year" do
            it "raises a NoEligibleStatsFoundError" do
              assert_calculator_raised(NoEligibleStatsFoundError, 2010, 'OAK')
            end
          end

          context "and there are stats available for a meaningful answer" do
            it "returns the slugging percentage for each player found" do
              # (( H - 2B - 3B - HR) + (2 * 2B) + (3 * 3B) + (4 * HR)) / AB
              #
              # allenbr01
              # ((30 - 9 - 2 - 3) + (2 * 9) + (3 * 2) + (4 * 3)) / 146
              # (16 + 18 + 6 + 12) / 146
              # 52 / 146 = 0.356
              #
              # allenbr02
              # ((43 - 7 - 1 - 5) + (2 * 7) + (3 * 1) + (4 * 5)) / 146
              # (30 + 14 + 3 + 20) / 146
              # 67 / 146 = 0.459
              #
              build_calculator(2011, 'OAK')
              calculator.calculate.should == {
                'allenbr01' => 0.356,
                'allenbr02' => 0.459
              }
            end
          end
        end
      end
    end
  end
end
