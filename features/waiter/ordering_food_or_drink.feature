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
  And I choose "Cam vắt"
  Then I see "Cam vắt" in ordered list
  And I see statistics "Đã chọn: 1 món"
  And I choose "Bún mộc"
  Then I see "Bún mộc" in ordered list
  And I see statistics "Đã chọn: 2 món"
