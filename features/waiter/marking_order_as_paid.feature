@javascript @order
Feature: Marking an order as paid
  As a waiter
  I want to mark an order as paid
  So I don't go ask them again

  Background:
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And the order is ready
    And the order is served
    And I'm on waiter page
    Then I see the order as unpaid

  Scenario: Marking an order as paid
    When I try to mark the order as paid
    And I confirm the dialog with "Đúng"
    Then I do not see "Order: Bàn số 1"


  Scenario: Cancel marking an order as paid
    When I try to mark the order as paid
    And I confirm the dialog with "Không"
    Then I see the order as unpaid
