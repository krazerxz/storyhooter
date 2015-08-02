Feature: User

  Scenario: New user joins the chain
    Given there is an existing completed user
    When I visit the new user page with the existing user uuid
    Then I should see the new user page
    When I fill in details for the new user
    Then I see the user show page

  Scenario: Viewing how the story has evolved past the current user
    Given there is an existing story
    When I visit a user in the middle of the chain
    Then I should see the future of the story

    @wip
  Scenario: Visiting a completed user page
    Given there is a completed user in the database
    When I visit the user show page
    Then I should see details about the user
