@javascript
Feature: Marking order as ready
  As a chef
  I want to mark an order as ready
  So waiter can know and act on it

  Scenario: Marking a preloaded order
    Given an order of table 1 is committed
    And I'm on chef page
    Then I see "Order: Bàn số 1" in waiting list
    When I mark order of table 1 as ready
    Then I do not see "Order: Bàn số 1" in waiting list

  Scenario: Marking a live updated order
    Given I'm on chef page
    When an order of table 1 is committed
    Then I see "Order: Bàn số 1" in waiting list
    When I mark order of table 1 as ready
    Then I do not see "Order: Bàn số 1" in waiting list


