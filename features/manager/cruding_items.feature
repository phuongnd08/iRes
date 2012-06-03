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
    And I assign the item price to "10000"
    And I choose "Lưu"
    Then I see "Mực nướng"
    And I see "10000"
    And category "Đồ ăn" has item "Mực nướng"

  Scenario: Edit an item
    When I choose "Bún bò"
    And I assign the item name to "Vermicelli"
    And I assign the item price to "20000"
    And I choose "Lưu"
    Then I see "Vermicelli"
    And I see "20000"
    But I do not see "Bún bò"

 Scenario Outline: Use inappropriate name and price for item
    When I choose "Thêm món"
    And I assign the item name to <name>
    And I assign the item price to <price>
    And I choose "Lưu"
    Then I see notice "<error>"

    Examples:
      |name|price|error|
      |blank|"10000"|Tên không thể để trống|
      |"Bún bò"|"10000"|Tên không được trùng với catalog khác|
      |blank|""|Giá không thể để trống|
      |blank|"abc"|Giá phải là một số|

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
