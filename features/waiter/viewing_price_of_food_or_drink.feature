@javascript @order
Feature: Viewing price of food or drink
  As a waiter
  I want to know the price of food or drink
  So I can answer my customer if they ask

  Scenario:
    Given I'm on waiter page
    When I choose "Đặt bàn"
    Then I see "15000" for drink "Cam vắt"
    And I see "20000" for food "Bún bò"
