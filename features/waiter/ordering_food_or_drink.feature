@javascript @order
Feature: Order food or drink
  As a waiter
  I want to order a food/drink
  So I can serve my customer

  Background:
    Given I'm on waiter page
    When I choose "Đặt bàn"

  Scenario: Order original food/drink
    When I choose "Bàn số 4" as table number
    And I choose item "Cam vắt"
    Then I see "Cam vắt" in ordered list
    And I see "1" as number of items of order
    And I choose item "Bún bò"
    Then I see "Bún bò" in ordered list
    And I see "2" as number of items of order
    And I see "35000" as the total price of order
    When I remove "Bún bò" from ordered list
    Then I see "1" as number of items of order
    And I see "15000" as the total price of order
    When I commit the order
    Then I see "Order: Bàn số 4"
    When I choose order of table 4
    Then I see 1 items being ordered
    And I see "Cam vắt" in the ordered list

  Scenario: Order food/drink with extra request
    And I choose item "Cam vắt"
    Then I see "Cam vắt" in ordered list
    When I set notes of "Cam vắt" to "Ít đá"
    Then I see "Ít đá"
    When I commit the order
    Then I see "Order: Bàn số 1"
    And I see "Cam vắt"
    And I see "Ít đá"

  Scenario: Not commiting an order
    Then I'm presented with the new order page
    And I stop committing the order
    Then I see no orders
