@javascript @order
Feature: Hearing sound when a food is added
  As a waiter
  I want to hear a sound when I add a food to an order
  So I'm not confused if the food is added or not

  Scenario: Add a food to an order
    Given I'm on waiter page
    When I choose "Đặt bàn"
    And I listen to the audio
    And I choose item "Cam vắt"
    Then I hear "added.mp3"
