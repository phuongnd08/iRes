@javascript @order
Feature: Exporting order to excel
  As a manager
  I want to export orders to excel
  So I can interact with different system

  Scenario: Export order to excel
    Given an order of table 1 is committed at 9:00
    And the order is paid at 10:00
    And I'm on manager page
    And I choose "Order: Bàn số 1"
    Then I am able export the order to excel
