Feature: Homepage

  Scenario: Viewing the homepage
    Given there are some users in the database
    When I visit the homepage
    Then I should see the homepage
