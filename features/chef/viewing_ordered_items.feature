@javascript @order
Feature: Seeing ordered items
  As a chef
  I want to see ordered items
  So I know what to prepare

  Scenario: View list of ordered items as page is reloaded
    Given these items are ordered:
      |category|name|
      |Đồ uống|Cam vắt|
      |Đồ ăn|Bún bò|
    When I'm on chef page
    Then I see 2 items in the waiting list
    And I see "Cam vắt" in the waiting list
    And I see "Bún bò" in the waiting list

  Scenario: View list of ordered items live updated
    Given I'm on chef page
    Then I see 0 items in the waiting list
    When these items are ordered:
      |category|name|
      |Đò uống|Cà phê|
      |Đò ăn|Bún bò|
    Then I see 2 items in the waiting list
    And I see "Cà phê" in the waiting list
    And I see "Bún bò" in the waiting list
    When this item is removed:
      |category|name|
      |Đò uống|Cà phê|
    Then I see 1 items in the waiting list
    And I see "Bún bò" in the waiting list
    But I do not see "Cà phê" in the waiting list
