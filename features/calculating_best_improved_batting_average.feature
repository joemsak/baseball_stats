Feature: Calculating the best improved batting average from 2009 to 2010
  The customer has a CSV of baseball stats
  That includes the At-Bats and Hits for each player from 2007 to 2012
  The customer wants to see the best improved batting average in 2009-2010

  Scenario: No stats exist
    Given that no stats exist
    When I create an improved batting average calculator
    Then calling calculate should raise NoStatsToCalculateError

  Scenario: Stats exist, but no one has 200 At-Bats
    Given that not enough at-bats exist for a batting average
    When I create an improved batting average calculator
    Then I should see there aren't enough at-bats to calculate

  Scenario: Enough stats exist for one player
    Given that enough at-bats exist for one player
    When I create an improved batting average calculator
    Then calling calculate should return the player

