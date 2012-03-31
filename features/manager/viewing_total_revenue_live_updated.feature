@javascript @order
Feature: Viewing total revenue live updated
  As a manager
  I want to see total revenue live updated
  So I know how the restaurant is operating

  Scenario: Viewing total revenue live updated
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ uống |Cà phê|
    And the order is paid
    And an order of table 2 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
    And I'm on manager page
    Then I see collected revenue of 10000
    When the order is paid
    Then I see collected revenue of 30000

  Scenario: View total revenue of the previous day
    Given an order of table 1 is committed yesterday with these items:
      |category|name|
      |Đồ uống |Cà phê|
    And the order is paid
    And I'm on manager page
    Then I see collected revenue of 0
    When I switch to yesterday statistics
    Then I see collected revenue of 10000
    When an order of table 2 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
    And the order is paid
    Then I still see collected revenue of 10000
    When I switch to today statistics
    Then I see collected revenue of 20000
