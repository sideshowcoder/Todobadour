Feature: Manage todos

  In order to manage todos
  As a viewer
  I want to be able to create, update, and delete todos

  Scenario: Create todo
    Given I am viewing the "Shopping" list
    When I create the todo "Buy some butter"
    Then I should see "Buy some butter"

