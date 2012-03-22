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
