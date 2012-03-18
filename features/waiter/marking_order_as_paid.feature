@javascript @order
Feature: Marking an order as paid
  As a waiter
  I want to mark an order as paid
  So I don't go ask them again

  Scenario: Marking an order as paid
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And I'm on waiter page
    Then I see the order as unpaid
    When I try to mark the order as paid
    And I confirm the dialog with "Đúng"
    Then I see the order as paid

  Scenario: Cancel marking an order as paid
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And I'm on waiter page
    When I try to mark the order as paid
    And I confirm the dialog with "Không"
    Then I see the order as unpaid
