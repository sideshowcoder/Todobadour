Feature: About page

  In order to inform myself about todobadour
  As a viewer
  I want to see the about page

  Scenario: Visit the about page
    Given I am on the "Home" page
    When I follow the "About" link
    Then I should see "Todobadour - About" in the title

