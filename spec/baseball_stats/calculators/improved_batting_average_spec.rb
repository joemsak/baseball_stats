require 'spec_helper'
require 'baseball_stats/calculators'

module BaseballStats
  module Calculators
    describe ImprovedBattingAverage do
      def build_calculator(stats, year)
        @calculator = ImprovedBattingAverage.new(stats, year)
      end

      def assert_calculate_raised(error, stats, year)
        build_calculator(stats, year)
        expect {
          @calculator.calculate
        }.to raise_error(error)
      end

      describe "#caclulate" do
        let(:stats) do
          "playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS"
        end

        context "when no stats exist" do
          it "raises a NoStatsToCalculateError" do
            expect {
              build_calculator(stats, 2001)
            }.to raise_error(NoStatsToCalculateError)
          end
        end

        context "when some stats exist" do
          before do
            stats << "\naardsda01,2009,AL,SEA,73,200,0,180,0,0,0,0,0,0"
            stats << "\naardsda01,2010,AL,SEA,73,200,0,180,0,0,0,0,0,0"
          end

          context "but no one has 200 at-bats" do
            before { stats.gsub!(/,200,/, ',199,') }

            it "raises a NotEnoughStatsFoundError" do
              assert_calculate_raised(NotEnoughStatsFoundError, stats, 2009)
            end
          end

          context "but no one is in the date range" do
            it "raises a NotEnoughStatsFoundError" do
              assert_calculate_raised(NotEnoughStatsFoundError, stats, 2011)
            end
          end

          context "and there are enough to calculate a meaningful answer" do
            before do
              stats << "\naardsda02,2009,AL,SEA,73,200,0,180,0,0,0,0,0,0"
              stats << "\naardsda02,2010,AL,SEA,73,200,0,190,0,0,0,0,0,0"
            end

            it "returns the playerID of the most improved player" do
              build_calculator(stats, 2010)
              @calculator.calculate.should == 'aardsda02'
            end
          end
        end
      end
    end
  end
end
