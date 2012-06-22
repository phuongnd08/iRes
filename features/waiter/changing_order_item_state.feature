@javascript @order
Feature: Changing order item state
  As a waiter
  I want to mark an order as served
  So we all know which one to take care next

  Scenario: Marking an ready order item as served
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And the order is ready
    And I'm on waiter page
    Then I see "Order: Bàn số 1"
    And I see order item "Bún bò" as ready
    And I see order item "Hủ tiếu mì" as ready
    When I mark order item "Bún bò" as served
    Then I see order item "Bún bò" as served
    When I mark order item "Hủ tiếu mì" as served
    Then I see the order as served

  Scenario: Cannot mark an unready order item as served
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    When I'm on waiter page
    Then I see order item "Bún bò" as unready
    And I cannot mark order item "Bún bò" as served
