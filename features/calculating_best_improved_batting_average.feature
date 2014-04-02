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

  Scenario: Enough stats exist for multiple players
    Given that enough at-bats exist for multiple players
    When I create an improved batting average calculator
    Then calling calculate should return the better player

  Scenario: Enough stats exist for multiple players out of date range
    Given that enough at-bats exist for multiple players out of date range
    When I create an improved batting average calculator
    Then calling calculate should return the better player in the date range

  Scenario: The calculator returns the best improved over the date range
    Given that enough at-bats exist for multiple players in date range
    When I create an improved batting average calculator
    Then calling calculate should return the most improved player
