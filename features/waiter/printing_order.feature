@javascript @order
Feature: Printing order
  As a waiter
  I want to print an order
  So I can distribute to my customer

  Scenario: Print an order
    Given an order of table 1 is committed with these items:
      |category|name|
      |Đồ ăn|Bún bò|
      |Đồ ăn|Hủ tiếu mì|
    And I'm on waiter page
    And I watch if the printer is printing
    When I try to print the order
    Then the printer prints
