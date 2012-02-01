@chef @order
Feature: Seeing ordered items
  As a chef
  I want to see ordered items
  So I know what to prepare

  Scenario: View list of ordered items as page is reloaded
    Given these items is ordered:
      |category|name|
      |Đồ uống|Cam vắt|
      |Đồ ăn|Bún bò|
    When I'm on chef page
    Then I see 2 items being listed
    And I see "Orange Juice" in the ordered list
    And I see "Vermicelli" in the ordered list

  Scenario: View list of ordered items live updated
    Given I'm on chef page
    Then I see 0 items being listed
    When 1 item is ordered:
      |category|name|
      |Đò uống|Cà phê|
    Then I see 1 items being listed
    And I see "Coffee" in the ordered list
