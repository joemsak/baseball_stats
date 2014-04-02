Feature: Calculating the best improved batting average from 2009 to 2010
  The customer has a CSV of baseball stats
  That includes the At-Bats and Hits for each player from 2007 to 2012
  The customer wants to see the best improved batting average in 2009-2010

  Scenario: No stats exist
    Given that no stats exist
    When I create an improved batting average calculator
    Then calling calculate should raise NoStatsToCalculateError

  Scenario: Stats exist for one player
    Given that some stats exist for one player
    When I create an improved batting average calculator
    Then calling calculate should return the player
