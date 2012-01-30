describe "Waiter", ->
  describe "current table number", ->
    beforeEach ->
      loadFixtures("order")
    it "is maintained across steps", ->
      Waiter.setCurrentTableNumber(4)
      Waiter.initializeOrderPage($("#order_page"))
      expect($('#order_page [data-role=header] h1')).
        toHaveText(I18n.t("order.for_table", { no: 4 }))
