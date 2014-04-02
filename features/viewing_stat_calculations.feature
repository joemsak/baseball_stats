Feature: Viewing stat calulations
  Certain historical stats about baseball players
  Have been provided by the customer
  The customer wants to view calculations of reported stats

  Scenario: No stats exist
    Given that no stats exist
    When I display the stats report
    Then I should see that no stats are available to calculate

  Scenario: The batting average stats exist
    Given that enough at-bats exist for multiple players in date range
    When I display the stats report
    Then I should see the calculated stats
