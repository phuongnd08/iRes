describe "Waiter", ->
  describe "order", ->
    beforeEach ->
      Waiter.orderingPage = null
      Waiter.orderedPage = null
      Waiter.orderedItems = []
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

      it "reupdates number of items indicator", ->
        Waiter.addItem(1, "Drink1")
        expect($('#ordered_page [data-role=header] .counter')).toHaveText('1')
        expect($('#ordering_page [data-role=header] .counter')).toHaveText('1')
        Waiter.addItem(2, "Drink2")
        expect($('#ordered_page [data-role=header] .counter')).toHaveText('2')
        expect($('#ordering_page [data-role=header] .counter')).toHaveText('2')

    describe "commitOrder", ->
      beforeEach ->
        loadFixtures("waiter_page")
        spyOn($, "ajax")
        spyOn($.mobile, "changePage")
        spyOn($.fn, "simpledialog")
        Waiter.commitOrder()

      commitParams = -> $.ajax.mostRecentCall.args[0]

      describe "when successfully", ->
        beforeEach -> commitParams().success()

        it "returns to waiter page", ->
          expect($.mobile.changePage).toHaveBeenCalled()
          expect($.mobile.changePage.mostRecentCall.args[0]).toBeTheSameNodeAs($('#navigator_page'))

      describe "when failed", ->
        beforeEach -> commitParams().error()

        it "show error message", ->
          expect($.fn.simpledialog).toHaveBeenCalled()
