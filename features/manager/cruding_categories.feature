@javascript
Feature: CRUD-ing categories
  As a manager
  I want to create, update, delete my categories
  So I can build the restaurant menu properly

  Scenario: Viewing list of categories
    Given these categories exists:
      |name|
      |Đồ ăn|
      |Đồ uống|
    And I am on manager page
    And I choose "Chỉnh sửa catalog"
    Then I see "Đồ ăn"
    And I see "Đồ uống"

  Scenario: Add a category
    Given I am on the categories page
    When I choose "Thêm catalog"
    And I assign the category name to "Food"
    And I choose "Lưu"
    Then I see "Food"
    And I have "Food" category

  Scenario: Edit a category
    Given these categories exists:
      |name|
      |Đồ ăn|
    Given I am on the categories page
    And I choose "Đồ ăn"
    And I choose "Chỉnh sửa hoặc xóa"
    And I assign the category name to "Food"
    And I choose "Lưu"
    Then I see "Food"
    But I do not see "Đồ ăn"

  Scenario: Cancel editing a category
    Given these categories exists:
      |name|
      |Đồ ăn|
      |Đồ uống|
    Given I am on the categories page
    And I choose "Đồ ăn"
    And I choose "Chỉnh sửa hoặc xóa"
    And I assign the category name to "Food"
    And I choose "Quay lại"
    Then I see "Đồ uống"
    And I see "Đồ ăn"

  Scenario: Destroy a category
    Given these categories exists:
      |name|
      |Đồ ăn|
      |Đồ uống|
    And I am on the categories page
    When I choose "Đồ ăn"
    And I choose "Chỉnh sửa hoặc xóa"
    And I choose "Xóa"
    And I confirm the dialog with "Đúng"
    Then I see "Đồ uống"
    But I do not see "Đồ ăn"
