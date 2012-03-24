@javascript @order
Feature: Marking an order as served
  As a waiter
  I want to mark an order as served
  So we all know which one to take care next

  Scenario: Marking an ready order as served
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And the order is ready
    And I'm on waiter page
    Then I see "Order: Bàn số 1"
    And I see the order as unserved
    When I try to mark the order as served
    And I confirm the dialog with "Đúng"
    And I see the order as served

  Scenario: Cannot mark an unready order as served
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And I'm on waiter page
    Then I see the order as unserved
    But I cannot mark the order as served
