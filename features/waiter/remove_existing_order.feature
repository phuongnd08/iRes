@javascript @order
Feature: Removing existing order
  As a waiter
  I want to remove an existing order
  So I can respond if customer decided to cancel their order

  Scenario: Removing an existing order
    Given an order of table 1 is committed
    And an order of table 2 is committed
    And I'm on waiter page
    When I choose "Order: Bàn số 1"
    And I cancel the order
    Then I see "Order: Bàn số 2"
    But I do not see "Order: Bàn số 1"
