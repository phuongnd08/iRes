@javascript @order
Feature: Marking order item as ready
  As a chef
  I want to mark an order item as ready
  So waiter can know and act on it

  Scenario: Marking a preloaded order item
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đò uống|Cà phê|
      |Đò ăn|Bún bò|
    And I'm on chef page
    When I mark item "Cà phê" as ready
    And I mark item "Bún bò" as ready
    Then I do not see "Order: Bàn số 1" in waiting list

  Scenario: Marking a live updated order
    Given I'm on chef page
    And an order of table 1 is committed with these items:
      |category|name|
      |Đò uống|Cà phê|
      |Đò ăn|Bún bò|
    When I mark item "Cà phê" as ready
    And I mark item "Bún bò" as ready
    Then I do not see "Order: Bàn số 1" in waiting list
