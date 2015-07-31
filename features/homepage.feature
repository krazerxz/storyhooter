Feature: Homepage

  Scenario: Viewing user statistics
    Given there are some users in the database
    When I visit the homepage
    Then I should see user statistics
