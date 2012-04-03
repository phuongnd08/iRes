@javascript
Feature: CRUD-ing items
  As a manager
  I want to create, update, delete my items
  So I can build the restaurant menu properly

  Background:
    Given these items exists:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu|
    Given I am on the categories page
    And I choose "Đồ ăn"

  Scenario: Add an item
    When I choose "Thêm món"
    And I assign the item name to "Mực nướng"
    And I choose "Lưu"
    Then I see "Mực nướng"
    And category "Đồ ăn" has item "Mực nướng"

  Scenario: Edit an item
    When I choose "Bún bò"
    And I assign the item name to "Vermicelli"
    And I choose "Lưu"
    Then I see "Vermicelli"
    But I do not see "Bún bò"

  Scenario: Cancel editing a category
    When I choose "Bún bò"
    And I assign the item name to "Vermicelli"
    And I choose "Quay lại"
    Then I see "Hủ tiếu"
    And I see "Bún bò"

  Scenario: Delete an item
    When I choose "Bún bò"
    And I choose "Xóa"
    And I confirm the dialog with "Đúng"
    Then I see "Hủ tiếu"
    But I do not see "Bún bò"
