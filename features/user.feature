Feature: User

  Scenario: New user joins the chain
    Given there is an existing completed user
    When I visit the new user page with the existing user uuid
    Then I should see the new user page
    When I fill in details for the new user
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
