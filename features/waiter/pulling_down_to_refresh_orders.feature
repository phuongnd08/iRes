@javascript
Feature: Pulling down to refresh orders
  As a waiter
  I want to refresh the orders if I pull the list down
  So I can resort to incase some error happens

  Scenario: Pulling the order list down
    Given I'm on waiter page
    And I observe if the page is reloaded
    When I pull the page down
    Then the page is reloaded
