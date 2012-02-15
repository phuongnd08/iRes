@javascript @order
Feature: Order food or drink
  As a waiter
  I want to order a food/drink
  So I can serve my customer

  Scenario: Order original food/drink
  Given I'm on waiter page
  When I choose "Đặt bàn"
  And I choose "Bàn số 4" as table number
  And I choose item "Cam vắt"
  Then I see "Cam vắt" in ordered list
  And I see "1" within ordered statistics
  And I choose item "Bún bò"
  Then I see "Bún bò" in ordered list
  And I see "2" within ordered statistics
  When I commit the order
  Then I see "Order: Bàn số 4"
  When I choose "Order: Bàn số 4"
  Then I see 2 items being listed
  And I see "Cam vắt" in the ordered list
  And I see "Bún bò" in the ordered list
