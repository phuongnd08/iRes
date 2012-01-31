describe "Waiter", ->
  describe "order", ->
    beforeEach ->
      Waiter.orderingPage = null
      Waiter.orderedPage = null
      loadFixtures("order")
    describe "current table number", ->
      it "is maintained across steps", ->
        Waiter.setCurrentTableNumber(4)
        expect($('#ordering_page [data-role=header] h1')).
          toHaveText(I18n.t("order.for_table", { no: 4 }))

        expect($('#ordered_page [data-role=header] h1')).
          toHaveText(I18n.t("order.for_table", { no: 4 }))

    describe "adding item", ->
      beforeEach ->
        $('#ordered_page').page()

      afterEach ->
        $('#ordered_page').remove()

      it "puts item in ordered list", ->
        Waiter.addItem(1, "Drink1")
        expect($('#ordered_page [data-role=content] li:first')).toExist()
        expect($('#ordered_page [data-role=content] li:first')).toHaveText("Drink1")
