Feature: Manage todos

  In order to manage todos
  As a viewer
  I want to be able to create, update, and delete todos

  Background: 
    Given There is a list named "Shopping"

  Scenario: Create todo
    When I am viewing the "Shopping" list
    And I create a todo "Buy some butter"
    Then I should see "Buy some butter"

  @javascript
  Scenario: Mark a todo done
    Given there is a todo named "Buy some butter" marked not done
    When I am viewing the "Shopping" list
    And I toggle the todo "Buy some butter" done
    And I am reloading the "Shopping" list
    Then I should see the todo "Buy some butter" marked as done

  @javascript
  Scenario: Mark a todo undone
    Given there is a todo named "Buy some butter" marked done
    When I am viewing the "Shopping" list
    And I toggle the todo "Buy some butter" done
    And I am reloading the "Shopping" list
    Then I should see the todo "Buy some butter" marked as not-done

  Scenario: Delete a todo
    Given there is a todo named "Buy some butter"
    When I am viewing the "Shopping" list
    And I delete the todo "Buy some butter"
    Then I should not see the todo "Buy some butter"

  @javascript
  Scenario: Change the text of a todo
    Given there is a todo named "Buy some butter"
    When I am viewing the "Shopping" list
    And I click on the todo title
    And I fill in "Buy some milk"
    And I am reloading the "Shopping" list
    Then I should see "Buy some milk"

