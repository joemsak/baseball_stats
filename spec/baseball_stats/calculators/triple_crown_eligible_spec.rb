require 'spec_helper'
require 'baseball_stats/calculators'

module BaseballStats
  module Calculators
    describe TripleCrownEligible do
      include CalculatorTestHelper
      subject { TripleCrownEligible }

      def assert_eligible_for(year, id1, id2)
        build_calculator(year)
        calculator.calculate.should == {
          'American League' => id1,
          'National League' => id2
        }
      end

      describe "#calculate" do
        context "when no stats exist" do
          it "raises a NoStatsToCalculateError" do
            assert_calculator_raised(NoStatsToCalculateError, 2011)
          end
        end

        context "when stats exist" do
          before do
            # the eligible should be:
            # nl player 02, al player 02,
            stats << "\nnlplaye01,2011,NL,OAK,41,400,18,185,9,2,8,15,2,0"
            stats << "\nnlplaye02,2011,NL,OAK,41,400,18,195,9,2,8,15,2,0"
            stats << "\nnlplaye03,2011,NL,OAK,41,400,18,195,9,2,8,14,2,0"
            stats << "\nalplaye01,2011,AL,OAK,41,400,18,185,9,2,8,12,2,0"
            stats << "\nalplaye02,2011,AL,OAK,41,400,18,190,9,2,8,12,2,0"
            stats << "\nalplaye03,2011,NL,OAK,41,400,18,190,9,2,8,11,2,0"
          end

          context "but no one is found in the requested year" do
            it "returns id 0 for each league" do
              assert_eligible_for(2010, 0, 0)
            end
          end

          context "but no one has 400 at-bats" do
            before { stats.gsub!(/,400,/, ',399,') }

            it "returns id 0 for each league" do
              assert_eligible_for(2011, 0, 0)
            end
          end

          context "and eligible are found" do
            it "returns the player IDs for each league" do
              assert_eligible_for(2011, 'alplaye02', 'nlplaye02')
            end
          end
        end
      end
    end
  end
end
