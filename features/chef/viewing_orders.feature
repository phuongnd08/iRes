@javascript @order
Feature: Viewing orders
  As a chef
  I want to see (ordered) orders
  So I know what to prepare

  Scenario: View list of ordered items as page is reloaded
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ uống|Cam vắt|
      |Đồ ăn|Bún bò|
    When I'm on chef page
    Then I see 2 items in the waiting list
    And I see "Cam vắt" in the waiting list
    And I see "Bún bò" in the waiting list
    And I see "Order: Bàn số 1"

  Scenario: View list of ordered items live updated
    Given I'm on chef page
    Then I see 0 orders in the waiting list
    Given an order of table 1 is committed with these items:
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

  Scenario: Viewing list of orders live updated
    Given I'm on chef page
    Then I see 0 orders in the waiting list
    When an order of table 1 is committed
    And an order of table 2 is committed
    Then I see 2 orders in the waiting list
    And I see "Order: Bàn số 1"
    And I see "Order: Bàn số 2"
    When the order of table 1 is cancelled
    Then I see 1 orders in the waiting list
    And I see "Order: Bàn số 2"
    But I do not see "Order: Bàn số 1"

  Scenario: View order ordered time
    Given an order is committed at 9:00 with these items:
      |category|name|
      |Đồ uống|Cam vắt|
    And I'm on chef page
    Then I see 1 orders in the waiting list
    And I see "9:00"

  Scenario: View live updated order ordered time
    Given I'm on chef page
    When an order is committed at 9:00 with these items:
      |category|name|
      |Đồ uống|Cam vắt|
    Then I see 1 orders in the waiting list
    And I see "9:00"

  Scenario: View modified order being redisplayed
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ uống|Cam vắt|
      |Đồ ăn|Bún bò|
    When I'm on chef page
    And I see "Order: Bàn số 1"
    When I mark order of table 1 as ready
    Then I do not see "Order: Bàn số 1"
    When this items is added to the order:
      |category|name|
      |Đồ uống|Cà phê|
    Then I see "Order: Bàn số 1"
    And I see 3 items in the waiting list
    And I see 2 items in the waiting list being marked as ready
