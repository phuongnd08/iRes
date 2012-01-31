@javascript @order
Feature: Order food or drink
  As a waiter
  I want to order a food/drink
  So I can serve my customer

  Scenario: Order original food/drink
  Given I'm on waiter page
  When I choose "Đặt bàn"
  And I choose "Bàn số 4" as table number
  Then I see "Đặt món cho bàn số 4"
  And I choose item "Cam vắt"
  Then I see "Cam vắt" in ordered list
  And I see "1" within ordered statistics
  And I choose item "Bún bò"
  Then I see "Bún bò" in ordered list
  And I see "2" within ordered statistics
