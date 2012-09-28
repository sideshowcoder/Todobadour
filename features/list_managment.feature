Feature: List managment

  In order to manage lists 
  As a viewer
  I want to be able to create, update, delete a list 

  Scenario: Create a list from the homepage
    Given I am on the "Home" page
    When I create the "Launch party" list
    Then I should see "Launch party" as my list


