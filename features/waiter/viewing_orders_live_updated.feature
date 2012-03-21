@javascript @order
Feature: Viewing orders live updated
  As a waiter
  I want to see orders being live updated
  So I am aware about changes around

  Scenario: Viewing list of orders live updated
    Given I'm on waiter page
    When an order of table 1 is committed
    And an order of table 2 is committed
    Then I see "Order: Bàn số 1"
    And I see "Order: Bàn số 2"
    When the order of table 1 is cancelled
    Then I see "Order: Bàn số 2"
    But I do not see "Order: Bàn số 1"

  Scenario: Viewing served and paid order live removed from the list
    Given I'm on waiter page
    When an order of table 1 is committed
    Then I see "Order: Bàn số 1"
    When the order is served
    And the order is paid
    Then I do not see "Order: Bàn số 1"

  Scenario: Do not see the served and paid order when first open the waiter page
    Given an order of table 1 is committed
    And the order is served
    And the order is paid
    When I'm on waiter page
    Then I do not see "Order: Bàn số 1"

  Scenario: View order ordered time
    Given an order is committed at 9:00 with these items:
      |category|name|
      |Đò uống|Cà phê|
    And I'm on waiter page
    Then I see "9:00"

  Scenario: View live updated order ordered time
    Given I'm on waiter page
    When an order is committed at 9:00 with these items:
      |category|name|
      |Đò uống|Cà phê|
    Then I see "9:00"

  Scenario: View order price live updated
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đò uống|Cà phê|
      |Đò ăn|Bún bò|
    And I'm on waiter page
    Then I see "30000"
    When this item is added to the order:
      |category|name|
      |Đò uống|Cam vắt|
    Then I see "45000"

  Scenario: Know when an order is ready
    Given I'm on waiter page
    When an order of table 1 is committed with these items:
      |category|name|
      |Đò uống|Cà phê|
    And the order is ready
    Then I see toast of "Order: Bàn số 1" with text "Sẵn sàng"
    And I see the order as ready

  Scenario: Viewing list of orders live updated after navigate away to ordering page
    Given I'm on waiter page
    When I choose "Đặt bàn"
    And an order of table 1 is committed
    And an order of table 2 is committed
    And an order of table 3 is committed
    And the order of table 1 is cancelled
    And the order of table 2 is paid
    And I choose "Quay lại"
    Then I see "Order: Bàn số 2"
    And I see "Order: Bàn số 3"
    But I do not see "Order: Bàn số 1"
    And I see the order of table 2 as paid
