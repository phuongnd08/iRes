@javascript @order
Feature: Viewing paid orders live updated
  As a manager
  I want to see paid order being live updated
  So I know how the restaurant is operating

  Scenario: Viewing paid order live added to the list
    Given an order of table 1 is committed at 9:00
    And the order is paid at 10:00
    And an order of table 2 is committed at 9:00
    And I'm on manager page
    Then I see "Order: Bàn số 1"
    And I see timing of order 1 reported as "9:00 (10:00)"
    But I do not see "Order: Bàn số 2"
    When the order is paid at 11:00
    Then I see "Order: Bàn số 2"
    And I see timing of order 2 reported as "9:00 (11:00)"
