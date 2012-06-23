@javascript @order
Feature: Hearing sound when order state changed
  As a waiter
  I want to hear sound when ever an order state is changed
  So I can easily notified

  Scenario: Order state changed
    Given I'm on waiter page
    And I listen to the audio
    When an order is committed with these items:
      |category|name|
      |Đò uống|Cà phê|
    Then I hear "new.mp3"
    When the order is ready
    Then I hear "ready.mp3"
    When the order is served
    Then I hear "served.mp3"
    When I try to mark the order as paid
    And I confirm the dialog with "Đúng"
    Then I hear "paid.mp3"
