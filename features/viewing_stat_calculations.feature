Feature: Viewing stat calulations
  Certain historical stats about baseball players
  Have been provided by the customer
  The customer wants to view calculations of reported stats

  Scenario: No stats
    Given that no stats exist
    When I display the "ImprovedBattingAverage" report with args:
      |2010|
    Then I should see that no stats are available to calculate
    When I display the "SluggingPercentage" report with args:
      |2010|OAK|
    Then I should see that no stats are available to calculate
    When I display the "TripleCrownEligible" report with args:
      |2010|
    Then I should see that no stats are available to calculate

  Scenario: Not enough stats for batting average
    Given that not enough stats exist for batting average
    When I display the "ImprovedBattingAverage" report with args:
      |2010|
    Then I should see that not enough stats were found

  Scenario: The most improved batting average
    Given that enough at-bats exist for the batting average
    When I display the "ImprovedBattingAverage" report with args:
      |2010|
    Then I should see the most improved batting average

  Scenario: No eligible stats for slugging percentage
    Given that no eligible stats exist for slg
    When I display the "SluggingPercentage" report with args:
      |2007|OAK|
    Then I should see that no eligible stats were found

  Scenario: The slugging percentage for a year and team
    Given that eligible stats exist for slg
    When I display the "SluggingPercentage" report with args:
      |2007|OAK|
    Then I should see the slg for the team and year specified

  Scenario: No triple crown winner for the year
    Given that no triple crown winner is in the stats for the year
    When I display the "TripleCrownEligible" report with args:
      |2012|
    Then I should see there was no winner

  Scenario: No triple crown winner for the league
    Given that no triple crown winner is in the stats for the league
    When I display the "TripleCrownEligible" report with args:
      |2012|
    Then I should see there was no winner

  Scenario: The triple crown winners
    Given that there is eligible data for the triple crown winners
    When I display the "TripleCrownEligible" report with args:
      |2012|
    Then I should see the triple crown winners
