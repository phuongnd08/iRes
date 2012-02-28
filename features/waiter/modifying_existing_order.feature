@javascript @order
Feature: Modifying existing order
  As a waiter
  I want to modify an existing order
  So I can respond to changes

  Scenario: Adding an item to an existing order
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And I'm on waiter page
    When I choose "Order: Bàn số 1"
    And I choose item "Cam vắt"
    And I see "3" within ordered statistics
    When I commit the order
    Then I see "Order: Bàn số 1"
    And I choose "Order: Bàn số 1"
    Then I see 3 items being ordered

  Scenario: Removing an item from an existing order
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And I'm on waiter page
    When I choose "Order: Bàn số 1"
    And I remove "Bún bò" from ordered list
    When I commit the order
    Then I see "Order: Bàn số 1"
    And I choose "Order: Bàn số 1"
    Then I see 1 items being ordered
    And I see "Hủ tiếu mì" in the ordered list
    And I do not see "Bún bò" in the ordered list