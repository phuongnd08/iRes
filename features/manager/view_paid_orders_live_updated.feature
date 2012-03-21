@javascript @order
Feature: Viewing paid orders live updated
  As a manager
  I want to see paid order being live updated
  So I know how the restaurant is operating

  Scenario: Viewing paid order live added to the list
    Given an order of table 1 is committed
    And the order is paid
    And an order of table 2 is committed
    And I'm on manager page
    Then I see "Order: Bàn số 1"
    But I do not see "Order: Bàn số 2"
    When the order is paid
    Then I see "Order: Bàn số 2"
