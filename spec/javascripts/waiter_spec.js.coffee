describe "Waiter", ->
  describe "current table number", ->
    beforeEach ->
      Waiter.orderPage = null
      loadFixtures("order")
    it "is maintained across steps", ->
      Waiter.setCurrentTableNumber(4)
      Waiter.initializeOrderPage($("#ordering_page"))
      expect($('#ordering_page [data-role=header] h1')).
        toHaveText(I18n.t("order.for_table", { no: 4 }))
