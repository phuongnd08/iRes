describe "Waiter", ->
  describe "order", ->
    beforeEach ->
      Waiter.orderingPage = null
      Waiter.orderedPage = null
      Waiter.orderedItems = []
      loadFixtures("order")
      $('#order_page').page()

    afterEach ->
      $('#order_page').remove()

    describe "adding item", ->
      beforeEach ->
        $('#ordered_page').page()

      afterEach ->
        $('#ordered_page').remove()

      it "puts item in ordered list", ->
        Waiter.addItem(1, "Drink1")
        expect($('#ordered li:first')).toExist()
        expect($('#ordered li:first a span').text()).toEqual("Drink1")

      it "reupdates number of items indicator", ->
        Waiter.addItem(1, "Drink1")
        expect($('#order_page .counter')).toHaveText('1')
        Waiter.addItem(2, "Drink2")
        expect($('#order_page .counter')).toHaveText('2')

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
          expect($.mobile.changePage).toHaveBeenCalledWith("/waiter")

      describe "when failed", ->
        beforeEach -> commitParams().error()

        it "show error message", ->
          expect($.fn.simpledialog).toHaveBeenCalled()
