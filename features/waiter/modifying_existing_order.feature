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
    When I choose order of table 1
    And I choose item "Cam vắt"
    And I see "3" as number of items of order
    And I see "60000" as the total price of order
    When I commit the order
    Then I see "Order: Bàn số 1"
    And I choose order of table 1
    Then I see 3 items being ordered
    And I see "60000" as the total price of order

  Scenario: Removing an item from an existing order
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And I'm on waiter page
    When I choose order of table 1
    And I remove "Bún bò" from ordered list
    And I see "25000" as the total price of order
    When I commit the order
    Then I see "Order: Bàn số 1"
    And I choose order of table 1
    Then I see 1 items being ordered
    And I see "Hủ tiếu mì" in the ordered list
    And I do not see "Bún bò" in the ordered list
    And I see "25000" as the total price of order

  Scenario: Cannot remove a ready item
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And item "Bún bò" is marked as ready
    And I'm on waiter page
    When I choose order of table 1
    Then I cannot remove "Bún bò" from ordered list
