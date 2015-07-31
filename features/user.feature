Feature: User

  Scenario: Editing an uncompleted user page
    Given there is an uncompleted user in the database
    When I visit the user edit page
    And I fill in details for the user
    Then I see the user show page

    @wip
  Scenario: Editing a completed user page
    Given there is a completed user in the database
    When I visit the user edit page
    Then I should be redirected to the user show page

    @wip
  Scenario: Visiting a completed user page
    Given there is a completed user in the database
    When I visit the user show page
    Then I should see details about the user
